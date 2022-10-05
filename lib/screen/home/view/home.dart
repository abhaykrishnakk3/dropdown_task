
import 'package:dropdown/screen/categories/view/categories_screen.dart';
import 'package:dropdown/screen/home/controller/home_controller.dart';
import 'package:dropdown/screen/home/view/widget/input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homecontroller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Home page")),
      body: SafeArea(child: GetBuilder<HomeController>(builder: (controller) {
        
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                  child: Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton(
                        isExpanded: true,
                        value:controller.selectedCategory?.name,
                        items: controller.categories
                            .map((e) => DropdownMenuItem<String>(value: e.name,child: Text(e.name)))
                            .toList(),
                        onChanged: (value) =>
                            controller.setCurrentCategory(value)),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => InputDialog(
                              title: "Add Category",
                              subTitle: "Category Name",
                              onconform: (value) {
                                if (controller.isCategoryExist(value)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const   SnackBar(
                                        backgroundColor: Colors.red,
                                          content:
                                              Text("Category  already exist")));
                                } else {
                                  controller.addCategory(value);
                                  Navigator.of(context).pop();
                                }
                              }),
                        );
                      },
                      icon: Icon(Icons.add))
                ],
              ),
               SizedBox(height: MediaQuery.of(context).size.height*0.04,),
              Visibility(
                visible: controller.selectedCategory!=null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub Categories",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(onPressed: () {
                      
                       showDialog(
                            context: context,
                            builder: (context) => InputDialog(
                                title: "Add Sub Category",
                                subTitle: "Sub Category Name",
                                onconform: (value) {
                                  if (controller.isSubCategoryExist(value)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const   SnackBar(
                                          backgroundColor: Colors.red,
                                            content:
                                                Text("Sub Category is already exist")));
                                  } else {
                                    controller.addSubCategory(value);
                                    Navigator.of(context).pop();
                                  }
                                }),
                          );
                    }, icon: Icon(Icons.add))
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.selectedCategory?.subCategories.length??0,
                  itemBuilder: (ctx,index){
                    return Text(controller.selectedCategory!.subCategories[index]);
                }),
              )
            ],
          ),
        );
      })),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(()=>CategoriesScreen());
      },mini: true,child: Icon(Icons.arrow_forward_ios_sharp),),
    );
  }
}
