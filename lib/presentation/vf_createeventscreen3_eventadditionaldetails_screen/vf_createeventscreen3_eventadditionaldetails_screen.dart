import 'package:flutter/material.dart';

import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:volufriend/presentation/vf_createeventscreen2_eventshifts_screen/bloc/vf_createeventscreen2_eventshifts_bloc.dart';
import '../../core/app_export.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/utils/validation_functions.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';

import '../../widgets/custom_text_form_field.dart';
import 'dart:io';
import 'bloc/vf_createeventscreen3_eventadditionaldetails_bloc.dart';

import '../../presentation/vf_createeventscreen1_eventdetails_screen/bloc/vf_createeventscreen1_eventdetails_bloc.dart';
import 'package:volufriend/widgets/vf_app_bar_with_title_back_button.dart';
import 'package:volufriend/widgets/custom_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VfCreateeventscreen3EventadditionaldetailsScreen extends StatelessWidget {
  VfCreateeventscreen3EventadditionaldetailsScreen({Key? key})
      : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // GlobalKey to access CustomImageField's saveImages method
  final GlobalKey<CustomImageFieldState> _imageFieldKey =
      GlobalKey<CustomImageFieldState>(); // Update here

  final List<String> tempUrlList = []; // Temporary list to store download URLs

  static Widget builder(BuildContext context) {
    final eventBloc =
        BlocProvider.of<VfCreateeventscreen1EventdetailsBloc>(context);
    final orgEvent =
        eventBloc.state.vfCreateeventscreen1EventdetailsModelObj?.orgEvent;

    final existingBloc =
        BlocProvider.of<VfCreateeventscreen3EventadditionaldetailsBloc>(context,
            listen: false);
    if (existingBloc != null) {
      existingBloc.add(VfCreateeventscreen3EventadditionaldetailsInitialEvent(
          orgEvent: orgEvent));
      return BlocProvider.value(
        value: existingBloc,
        child: BlocListener<VfCreateeventscreen3EventadditionaldetailsBloc,
            VfCreateeventscreen3EventadditionaldetailsState>(
          listener: (context, state) {
            if (state.isSavedtoDb) {
              print('Saved to DB');
              NavigatorService.pushNamed(AppRoutes.vfHomescreenContainerScreen);
            }
          },
          child: VfCreateeventscreen3EventadditionaldetailsScreen(),
        ),
      );
    } else {
      return BlocProvider<VfCreateeventscreen3EventadditionaldetailsBloc>(
        create: (context) => VfCreateeventscreen3EventadditionaldetailsBloc(
            vfcrudService: VolufriendCrudService())
          ..add(VfCreateeventscreen3EventadditionaldetailsInitialEvent()),
        child: BlocListener<VfCreateeventscreen3EventadditionaldetailsBloc,
            VfCreateeventscreen3EventadditionaldetailsState>(
          listener: (context, state) {},
          child: VfCreateeventscreen3EventadditionaldetailsScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VfCreateeventscreen3EventadditionaldetailsBloc,
        VfCreateeventscreen3EventadditionaldetailsState>(
      listener: (context, state) {},
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: VfAppBarWithTitleBackButton(
            title: context
                        .read<VfCreateeventscreen1EventdetailsBloc>()
                        .state
                        .formContext ==
                    "create"
                ? "Create Event - Additional Details"
                : "Edit Event - Additional Details",
            showSearchIcon: false,
            showFilterIcon: false,
            onBackPressed: () => Navigator.of(context).pop(),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAdditionalDetailsSection(context),
                  SizedBox(height: 16.h),
                  _buildUploadImageLabel(context),
                  _buildUploadImageSection(context),
                  SizedBox(height: 24.h),
                  _buildEventDetailsForm(context),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
            child: Row(
              children: [
                Expanded(child: _buildPrevButton(context)),
                SizedBox(width: 16.h),
                Expanded(child: _buildSaveButton(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalDetailsSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("msg_additional_details".tr,
              style: CustomTextStyles.bodySmallBlack900),
          SizedBox(height: 8.h),
          _buildAdditionalDetailsTextArea(context),
        ],
      ),
    );
  }

  Widget _buildAdditionalDetailsTextArea(BuildContext context) {
    return BlocSelector<
        VfCreateeventscreen3EventadditionaldetailsBloc,
        VfCreateeventscreen3EventadditionaldetailsState,
        TextEditingController?>(
      selector: (state) => state.additionalDetailsTextAreaController,
      builder: (context, additionalDetailsTextAreaController) {
        return CustomTextFormField(
          controller: additionalDetailsTextAreaController,
          hintText: "msg_click_here_to_enter3".tr,
          maxLines: 4,
          inputFormatters: [LengthLimitingTextInputFormatter(500)],
          textStyle: CustomTextStyles.bodyLargeGray800,
          textInputType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
        );
      },
    );
  }

  Widget _buildUploadImageLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        "lbl_event_image".tr,
        style: CustomTextStyles.bodySmallRobotoGray800,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildUploadImageSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: CustomImageField(
        key: _imageFieldKey, // Attach the GlobalKey here
        texts: const {
          'fieldFormText': 'Select or Upload Images',
          'titleText': 'Upload Event Images',
        },
        cardinality: 2,
        multipleUpload: true,
        thumbnailAddMoreDecoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8.0),
        ),
        pickerIconColor: Theme.of(context).primaryColor,
        pickerBackgroundColor: Colors.white,
        onSave: (List<CustomImageAndCaptionModel>? imageAndCaptionList) async {
          if (imageAndCaptionList != null) {
            for (var image in imageAndCaptionList) {
              try {
                final file = File(image.file);
                final bytes =
                    await file.readAsBytes(); // Convert to binary data

                // Pass tempUrlList to store each download URL
                await _uploadToFirebaseStorage(bytes, image.file, tempUrlList);
              } catch (e) {
                print("Failed to upload ${image.file}: $e");
              }
            }

            // After all uploads are done, tempUrlList will contain all URLs
            print("All uploaded file URLs: $tempUrlList");
          }
        },
        onUpload: (pickedFile, controllerLinearProgressIndicator) async {},
      ),
    );
  }

  Future<void> _uploadToFirebaseStorage(
      Uint8List fileData, String fileName, List<String> tempUrlList) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('VoluFriendEventImages/$fileName');

      // Upload the file to Firebase Storage
      final uploadTask = storageRef.putData(fileData);

      // Await the upload task completion
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Store the URL in the temporary list
      tempUrlList.add(downloadUrl);
      print("File uploaded. Download URL: $downloadUrl");
    } catch (e) {
      print("Failed to upload file to Firebase Storage: $e");
    }
  }

  Future<void> uploadAllFiles(
      List<Uint8List> fileDataList, List<String> fileNames) async {
    List<String> tempUrlList = [];

    for (int i = 0; i < fileDataList.length; i++) {
      await _uploadToFirebaseStorage(
          fileDataList[i], fileNames[i], tempUrlList);
    }

    // Print or use the URLs stored in tempUrlList
    print("All download URLs: $tempUrlList");
  }

// Mock function to simulate cloud upload
  Future<void> _mockUploadToCloudStorage(
      Uint8List fileData, String filePath) async {
    print("Uploading ${filePath.split('/').last} to cloud storage...");
    await Future.delayed(Duration(seconds: 2)); // Simulate upload time
    print("Upload complete for ${filePath.split('/').last}.");
  }

// Mock upload function with progress tracking
  Future<dynamic> uploadToServer(XFile? file,
      {required void Function(double) uploadProgress}) async {
    // Simulate a server upload process
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      uploadProgress(i * 10.0); // Update progress in increments
    }
    // Return uploaded file representation
    return file;
  }

  Widget _buildEventDetailsForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCoordinatorNameInput(context),
        SizedBox(height: 24.h),
        _buildCoordinatorEmailInput(context),
        SizedBox(height: 24.h),
        _buildCoordinatorPhoneInput(context),
        SizedBox(height: 32.h),
      ],
    );
  }

  Widget _buildCoordinatorNameInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.h),
      child: BlocSelector<
          VfCreateeventscreen3EventadditionaldetailsBloc,
          VfCreateeventscreen3EventadditionaldetailsState,
          TextEditingController?>(
        selector: (state) => state.coordinatorNameInputController,
        builder: (context, coordinatorNameInputController) {
          return CustomFloatingTextField(
            controller: coordinatorNameInputController,
            labelText: "msg_coordinator_name".tr,
            hintText: "msg_coordinator_name".tr,
            contentPadding: EdgeInsets.fromLTRB(16.h, 16.h, 16.h, 8.h),
            validator: (value) {
              if (!isText(value)) return "err_msg_please_enter_valid_text";
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _buildCoordinatorEmailInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.h),
      child: BlocSelector<
          VfCreateeventscreen3EventadditionaldetailsBloc,
          VfCreateeventscreen3EventadditionaldetailsState,
          TextEditingController?>(
        selector: (state) => state.coordinatorEmailInputController,
        builder: (context, coordinatorEmailInputController) {
          return CustomFloatingTextField(
            controller: coordinatorEmailInputController,
            labelText: "msg_coordinator_email".tr,
            hintText: "msg_coordinator_email".tr,
            textInputType: TextInputType.emailAddress,
            contentPadding: EdgeInsets.fromLTRB(16.h, 16.h, 16.h, 8.h),
            validator: (value) {
              if (value == null || !isValidEmail(value, isRequired: true)) {
                return "err_msg_please_enter_valid_email";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _buildCoordinatorPhoneInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.h),
      child: BlocSelector<
          VfCreateeventscreen3EventadditionaldetailsBloc,
          VfCreateeventscreen3EventadditionaldetailsState,
          TextEditingController?>(
        selector: (state) => state.coordinatorPhoneInputController,
        builder: (context, coordinatorPhoneInputController) {
          return CustomFloatingTextField(
            controller: coordinatorPhoneInputController,
            labelText: "msg_coordinator_phone".tr,
            hintText: "msg_coordinator_phone".tr,
            textInputType: TextInputType.phone,
            contentPadding: EdgeInsets.fromLTRB(16.h, 16.h, 16.h, 8.h),
            validator: (value) {
              if (!isValidPhone(value)) {
                return "err_msg_please_enter_valid_phone_number";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _buildPrevButton(BuildContext context) {
    return CustomElevatedButton(
      width: 106.h,
      text: "lbl_prev".tr,
      onPressed: () {
        context.read<VfCreateeventscreen3EventadditionaldetailsBloc>().add(
              SaveEventAdditionalDetailsEvent(saveIntentToDb: false),
            );
        NavigatorService.pushNamed(
            AppRoutes.vfCreateeventscreen2EventshiftsScreen);
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return BlocListener<VfCreateeventscreen3EventadditionaldetailsBloc,
        VfCreateeventscreen3EventadditionaldetailsState>(
      listenWhen: (previous, current) {
        // Simplified condition to only trigger when necessary
        return current.SaveDbIntent && !current.isSavedtoDb && current.isSaved;
      },
      listener: (context, state) async {
        if (state.isSaved && !state.isSavedtoDb) {
          final orgEvent = _handleEventDetails(context);
          if (orgEvent != null) {
            if (_imageFieldKey.currentState != null) {
              // Debounce mechanism to prevent repeated calls
              print("Save in progress: ${state.isSaveInProgress}");
              if (!state.isSaveInProgress) {
                context
                    .read<VfCreateeventscreen3EventadditionaldetailsBloc>()
                    .add(StartSaveInProgressEvent()); // Set save in progress

                await _imageFieldKey.currentState!.saveImages();

                context
                    .read<VfCreateeventscreen3EventadditionaldetailsBloc>()
                    .add(SaveEventShiftstoDbEvent(
                        orgEvent: orgEvent, imageUrls: tempUrlList));
              }
            }
          }
        }

        if (state.isSavedtoDb) {
          // Ensure navigation occurs only once after saving to DB
          NavigatorService.pushNamed(AppRoutes.vfHomescreenContainerScreen);
        }
      },
      child: CustomElevatedButton(
        width: 106.h,
        text: "lbl_save".tr,
        onPressed: () {
          // Trigger save action with a flag for saving intent
          context.read<VfCreateeventscreen3EventadditionaldetailsBloc>().add(
                SaveEventAdditionalDetailsEvent(saveIntentToDb: true),
              );
        },
      ),
    );
  }

  Voluevents? _handleEventDetails(BuildContext context) {
    final eventDetailsBloc =
        BlocProvider.of<VfCreateeventscreen1EventdetailsBloc>(context);
    final orgEvent = eventDetailsBloc
        .state.vfCreateeventscreen1EventdetailsModelObj?.orgEvent;

    if (eventDetailsBloc.state.isSaved) {
      final shiftDetailsBloc =
          BlocProvider.of<VfCreateeventscreen2EventshiftsBloc>(context);
      final shifts = shiftDetailsBloc
              .state.vfCreateeventscreen2EventshiftsModelObj?.eventShifts ??
          [];
      final additionalDetailsBloc =
          BlocProvider.of<VfCreateeventscreen3EventadditionaldetailsBloc>(
              context);
      final coordinator = additionalDetailsBloc.state
          .vfCreateeventscreen3EventadditionaldetailsModelObj?.coordinator;
      final eventDescription = additionalDetailsBloc.state
          .vfCreateeventscreen3EventadditionaldetailsModelObj?.description;

      if (additionalDetailsBloc.state.isSaved) {
        return Voluevents(
          eventId: orgEvent?.eventId ?? '',
          orgUserId: orgEvent?.orgUserId,
          address: orgEvent?.address,
          causeId: orgEvent?.causeId,
          endDate: orgEvent?.endDate,
          eventAlbum: orgEvent?.eventAlbum,
          eventStatus: orgEvent?.eventStatus,
          eventWebsite: orgEvent?.eventWebsite,
          location: orgEvent?.location,
          title: orgEvent?.title,
          orgId: orgEvent?.orgId,
          startDate: orgEvent?.startDate,
          regByDate: orgEvent?.regByDate,
          additionalDetails: orgEvent?.additionalDetails,
          EventHostingType: orgEvent?.EventHostingType,
          shifts: shifts,
          coordinator: coordinator,
          description: eventDescription,
          parentOrg: orgEvent?.parentOrg,
          orgName: orgEvent?.orgName,
        );
      }
    }
    return null;
  }
}
