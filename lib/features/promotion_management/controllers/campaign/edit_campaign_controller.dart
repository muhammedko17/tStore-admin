import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/banners/banners_repository.dart';
import '../../../../data/repositories/brands/brand_repository.dart';
import '../../../../data/repositories/categories/category_repository.dart';
import '../../../../data/repositories/products/products_repository.dart';
import '../../../../routes/routes.dart';

import '../../../../utils/constants/enums.dart';
import '../../../data_management/models/brand_model.dart';
import '../../../data_management/models/category_model.dart';
import '../../../media/controllers/media_controller.dart';
import '../../../media/models/image_model.dart';
import '../../../product_management/models/product_model.dart';
import '../../models/banner_model.dart';
import '../banner/banner_controller.dart';

import 'package:t_utils/t_utils.dart';

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();

  // Inject the repository
  final BannerRepository bannerRepository = Get.put(BannerRepository());
  final bannerController = Get.put(BannerController());

  final isLoading = false.obs;
  final isActive = true.obs;
  final isFeatured = true.obs;

  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final description = TextEditingController();
  final startDateTextField = TextEditingController();
  final endDateTextField = TextEditingController();
  final customUrlWebNameTextField = TextEditingController();
  final customUrlTextField = TextEditingController();
  final imageUrl = ''.obs;
  final bannerTargetType = BannerTargetType.homeScreen.obs;
  final bannerTargetTitle = ''.obs;
  final bannerTargetId = ''.obs;
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;

  final selectedProduct = ProductModel.empty().obs;
  final selectedCategory = CategoryModel.empty().obs;
  final selectedBrand = BrandModel.empty().obs;

  final banner = BannerModel.empty().obs;
  final bannerId = ''.obs;

  /// Init Data
  Future<void> init() async {
    try {
      isLoading.value = true;

      // Fetch record if argument was null
      if (banner.value.id.isEmpty) {
        if (bannerId.isEmpty) Get.toNamed(TRoutes.banners);

        banner.value = await bannerRepository.getSingleItem(bannerId.value);
      }

      title.text = banner.value.title;
      description.text = banner.value.description;
      imageUrl.value = banner.value.imageUrl;
      bannerTargetType.value = banner.value.targetType;
      bannerTargetId.value = banner.value.targetId ?? '';
      bannerTargetTitle.value = banner.value.targetTitle ?? '';
      customUrlTextField.text = banner.value.customUrl ?? '';

      startDate.value = banner.value.startDate ?? DateTime.now();
      endDate.value = banner.value.endDate ?? DateTime.now();
      startDateTextField.text = banner.value.startDate != null ? TFormatter.formatDate(banner.value.startDate) : '';
      endDateTextField.text = banner.value.endDate != null ? TFormatter.formatDate(banner.value.endDate) : '';
      isActive.value = banner.value.isActive;
      isFeatured.value = banner.value.isFeatured;

      if (bannerTargetId.value.isNotEmpty) {
        if (banner.value.targetType == BannerTargetType.productScreen) {
          final repo = Get.put(ProductRepository());
          selectedProduct.value = await repo.getSingleItem(bannerTargetId.value);
        } else if (banner.value.targetType == BannerTargetType.categoryScreen) {
          final repo = Get.put(CategoryRepository());
          selectedCategory.value = await repo.getSingleItem(bannerTargetId.value);
        } else if (banner.value.targetType == BannerTargetType.brandScreen) {
          final repo = Get.put(BrandRepository());
          selectedBrand.value = await repo.getSingleItem(bannerTargetId.value);
        }
      }
    } catch (e) {
      if (kDebugMode) printError(info: e.toString());
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Unable to fetch banner details. Try again.');
    } finally {
      isLoading.value = false;
    }
  }

  /// Register new Banner
  Future<void> updateBanner(BannerModel banner) async {
    try {
      // Start Loading
      isLoading.value = true;

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isLoading.value = false;
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        isLoading.value = false;
        return;
      }

      if (imageUrl.isEmpty) throw 'Select Banner Image';
      if (endDate.value.isBefore(startDate.value)) throw 'Choose Start and End Dates properly';

      _setTargetScreen();

      // Map Data
      banner.title = title.text.trim();
      banner.description = description.text.trim();
      banner.imageUrl = imageUrl.value;
      banner.targetType = bannerTargetType.value;
      banner.targetId = bannerTargetId.value;
      banner.targetTitle = bannerTargetTitle.value;

      banner.startDate = startDateTextField.text.trim().isEmpty ? null : startDate.value;
      banner.endDate = startDateTextField.text.trim().isEmpty
          ? null
          : endDateTextField.text.trim().isEmpty
              ? null
              : endDate.value;
      banner.isActive = isActive.value;
      banner.isFeatured = isFeatured.value;
      banner.updateAt = DateTime.now();

      // Call Repository to Create New User
      await BannerRepository.instance.updateItemRecord(banner);

      // Update All Data list
      BannerController.instance.updateItemFromLists(banner);

      // Reset Form
      resetFields();

      // Remove Loader
      isLoading.value = false;

      // Return
      Get.back();

      // Success Message & Redirect
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your Record has been updated.');
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Pick Image from Media
  Future<void> pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image to the main image or perform any other action
      imageUrl.value = selectedImages.first.url;
    }
  }

  void _setTargetScreen() {
    if (bannerTargetType.value == BannerTargetType.productScreen) {
      if (selectedProduct.value.id.isEmpty) throw 'Select Product as a Banner Target';
      bannerTargetId.value = selectedProduct.value.id;
      bannerTargetTitle.value = selectedProduct.value.title;
    } else if (bannerTargetType.value == BannerTargetType.categoryScreen) {
      if (selectedCategory.value.id.isEmpty) throw 'Select Category as a Banner Target';
      bannerTargetId.value = selectedCategory.value.id;
      bannerTargetTitle.value = selectedCategory.value.name;
    } else if (bannerTargetType.value == BannerTargetType.brandScreen) {
      if (selectedBrand.value.id.isEmpty) throw 'Select Brand as a Banner Target';
      bannerTargetId.value = selectedBrand.value.id;
      bannerTargetTitle.value = selectedBrand.value.name;
    } else if (bannerTargetType.value == BannerTargetType.customUrl) {
      if (customUrlTextField.text.trim().isEmpty) throw 'Add URL  as a Banner Target';
      bannerTargetId.value = '';
      bannerTargetTitle.value = customUrlWebNameTextField.text.trim().isEmpty ? 'Custom URL' : customUrlWebNameTextField.text.trim();
    } else {
      bannerTargetId.value = '';
      // bannerTargetTitle.value = selectedRetailer.value.name[0] + selectedRetailer.value.name.substring(1);
    }
  }

  /// Method to reset fields
  void resetFields() {
    title.clear();
    description.clear();
    imageUrl.value = '';
    bannerTargetTitle.value = '';
    bannerTargetId.value = '';
    bannerTargetType.value = BannerTargetType.homeScreen;
    startDateTextField.clear();
    endDateTextField.clear();
    startDate.value = DateTime.now();
    endDate.value = DateTime.now();
    isLoading(false);
    isActive.value = true;
    selectedBrand.value = BrandModel.empty();
    selectedCategory.value = CategoryModel.empty();
    selectedProduct.value = ProductModel.empty();
  }
}
