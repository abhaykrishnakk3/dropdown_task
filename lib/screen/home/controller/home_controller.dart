import 'package:dropdown/screen/home/model/category_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  List<CategoryModel> categories = [];
  CategoryModel? selectedCategory;
  addCategory(String name){
    CategoryModel newCategory=CategoryModel(name: name);
      categories.add(newCategory);
      selectedCategory=categories.last;
      update();
  }
  
  addSubCategory(String name){
    selectedCategory?.subCategories.add(name);
    update();
  }

  setCurrentCategory(dynamic name){
    int index = categories.indexWhere((element) => element.name==name);
    selectedCategory = categories[index];
    update();
  }
  bool isCategoryExist(String name){
    return categories.indexWhere((element) => element.name == name)!=-1;
  }

  bool isSubCategoryExist(String name){
    return selectedCategory?.subCategories.contains(name)??false;
  }

  void renameCategory(List<String> subCategories,int index,String name){
    subCategories[index] = name;
    update();
  }

}