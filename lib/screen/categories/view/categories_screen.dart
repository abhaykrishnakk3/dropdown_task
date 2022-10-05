import 'package:dropdown/screen/categories/model/indexmodel.dart';
import 'package:dropdown/screen/home/controller/home_controller.dart';
import 'package:dropdown/screen/home/model/category_model.dart';
import 'package:dropdown/screen/home/view/widget/input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  final List<IndexModel> selectedIndexes=[];
  final HomeController homeController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = homeController.categories;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        actions: [IconButton(onPressed: () {_deleteSelected();}, icon: const Icon(Icons.delete))],
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        selectedIndexes.clear();
        return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (ctx, index) {
              return ExpansionTile(
                title: Text(categories[index].name),
                children: categories[index]
                    .subCategories
                    .map(
                      (e) {
                        RxBool check=false.obs;
                        int ind=-1;
                        return ListTile(
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            Obx(()=> Checkbox(value: check.value, onChanged: (value) {
                              if(value==null)return;
                              if(value){
                                int sIndex = categories[index]
                                                  .subCategories
                                                  .indexOf(e);
                                selectedIndexes.add(IndexModel(index,sIndex ));
                                ind=selectedIndexes.length-1;
                              }else if(ind>0){
                                
                                selectedIndexes.removeAt(ind);
                              }
                              check.value=value;})),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => InputDialog(
                                          title: "Update Sub Category",
                                          subTitle: "Sub Category Name",
                                          initialvalue: e,
                                          conformText: 'Update',
                                          onconform: (value) {
                                            if (homeController
                                                .isSubCategoryExist(value)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                          "Sub Category is already exist")));
                                            } else {
                                              int sIndex = categories[index]
                                                  .subCategories
                                                  .indexOf(e);
                                              categories[index]
                                                      .subCategories[sIndex] =
                                                  value;
                                              homeController.update();
                                              Navigator.of(context).pop();
                                            }
                                          }));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                )),
                            IconButton(
                                onPressed: () {
                                  categories[index].subCategories.remove(e);
                                  homeController.update();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ))
                          ]),
                          title: Text(e));},
                    )
                    .toList(),
              );
            });
      }),
    );
  }
  _deleteSelected(){
    for(var index in selectedIndexes){
      homeController.categories[index.catIndex].subCategories.removeAt(index.subIndex);
    }
    homeController.update();
  }
}
