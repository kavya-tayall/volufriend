import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:volufriend/presentation/vf_createeventscreen2_eventshifts_screen/bloc/vf_createeventscreen2_eventshifts_bloc.dart';
import '../../core/app_export.dart';
import 'package:flutter/services.dart'; // Import for LengthLimitingTextInputFormatter
import 'package:image_picker/image_picker.dart'; // Import for XFile
import 'dart:io'; // Import for File
import 'package:image_field/image_field.dart';
import 'package:image_field/linear_progress_Indicator.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';
import '../../widgets/custom_phone_number.dart';
import '../../widgets/custom_text_form_field.dart';
import '../vf_homescreen_page/vf_homescreen_page.dart';
import 'bloc/vf_createeventscreen3_eventadditionaldetails_bloc.dart';
import 'models/vf_createeventscreen3_eventadditionaldetails_model.dart';
import '../../presentation/vf_createeventscreen1_eventdetails_screen/bloc/vf_createeventscreen1_eventdetails_bloc.dart';

// ignore_for_file: must_be_immutable
class VfCreateeventscreen3EventadditionaldetailsScreen extends StatelessWidget {
  VfCreateeventscreen3EventadditionaldetailsScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    final EventBloc =
        BlocProvider.of<VfCreateeventscreen1EventdetailsBloc>(context);
    final EventState = EventBloc.state;

    final orgEvent =
        EventState.vfCreateeventscreen1EventdetailsModelObj?.orgEvent;
    // print('Orgstate from shift: $orgEvent');

    // Check if the VfCreateeventscreen2EventshiftsBloc is already provided
    final existingBloc =
        BlocProvider.of<VfCreateeventscreen3EventadditionaldetailsBloc>(context,
            listen: false);
    print('ExistingBloc: $existingBloc');
    // If an existing Bloc is not found, create a new one
    if (existingBloc != null) {
      // Dispatch the initial event if the Bloc already exists
      existingBloc.add(VfCreateeventscreen3EventadditionaldetailsInitialEvent(
          orgEvent: orgEvent));
      return BlocProvider.value(
        value: existingBloc,
        child: BlocListener<VfCreateeventscreen3EventadditionaldetailsBloc,
            VfCreateeventscreen3EventadditionaldetailsState>(
          listener: (context, state) {
            if (state.isSavedtoDb) {
              // NavigatorService.pushNamed(AppRoutes.vfHomescreenContainerScreen);
              print('Saved to DB');
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
          listener: (context, state) {
            // Add your event listener logic here
          },
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
          appBar: _buildAppBar(context),
          body: Form(
            key: _formKey,
            child: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 64.h),
                  decoration: AppDecoration.fillBlueGray,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        decoration: AppDecoration.fillGray,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 18.h),
                            _buildAdditionalDetailsSection(context),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.h),
                              decoration: AppDecoration.fillCyan,
                              child: Column(
                                children: [
                                  Text(
                                    "lbl_event_image".tr,
                                    style:
                                        CustomTextStyles.bodySmallRobotoGray800,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 6.h),
                              child: Text(
                                "msg_upload_event_image".tr,
                                style: CustomTextStyles.bodyLargeGray800,
                              ),
                            ),
                            _buildUploadImageSection(context),
                            SizedBox(height: 18.h),
                            _buildEventDetailsForm(context),
                            SizedBox(height: 40.h)
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMegaphone,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 20.h,
          bottom: 20.h,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "lbl_title".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgSearch,
          margin: EdgeInsets.only(
            top: 20.h,
            right: 16.h,
            bottom: 20.h,
          ),
        )
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildSchoolAndOrgHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 6.h,
        right: 10.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 12.h,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder24,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "lbl_hi_john_doe".tr,
            style: theme.textTheme.titleMedium,
          ),
          Text(
            "msg_bothell_high_school".tr,
            style: theme.textTheme.titleMedium,
          )
        ],
      ),
    );
  }

  /// Section Widget
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
          inputFormatters: [
            LengthLimitingTextInputFormatter(500), // Limit to 500 characters
          ],
          textStyle:
              CustomTextStyles.bodyLargeGray800, // Use an existing text style
          textInputType: TextInputType.multiline,
          textInputAction: TextInputAction.newline, // Allow multiline input
        );
      },
    );
  }

  /// Section Widget
  Widget _buildAdditionalDetailsSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "msg_additional_details".tr,
            style: CustomTextStyles.bodySmallBlack900,
          ),
          SizedBox(height: 4.h),
          _buildAdditionalDetailsTextArea(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUploadImageSection(BuildContext context) {
    return Container(
      height: 150.h,
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Column(
        children: [
          ImageField(
            cardinality: 2, // Limit the number of images to 2
            onSave: (List<ImageAndCaptionModel>? imageAndCaptionList) {
              // you can save imageAndCaptionList using local storage
              // or in a simple variable
            },
          ),
        ],
      ),
    );
  }

  /// Section Widget
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
            labelStyle: theme.textTheme.bodyLarge!,
            hintText: "msg_coordinator_name".tr,
            contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
            validator: (value) {
              if (!isText(value)) {
                return "err_msg_please_enter_valid_text";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  /// Section Widget
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
            labelStyle: theme.textTheme.bodyLarge!,
            hintText: "msg_coordinator_email".tr,
            textInputType: TextInputType.emailAddress,
            contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
            validator: (value) {
              if (value == null || (!isValidEmail(value, isRequired: true))) {
                return "err_msg_please_enter_valid_email";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  /// Section Widget
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
            labelStyle: theme.textTheme.bodyLarge!,
            hintText: "msg_coordinator_phone".tr,
            textInputType: TextInputType.phone,
            contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
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

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return BlocBuilder<VfCreateeventscreen3EventadditionaldetailsBloc,
        VfCreateeventscreen3EventadditionaldetailsState>(
      builder: (context, state) {
        return CustomPhoneNumber(
          country: state.selectedCountry ??
              CountryPickerUtils.getCountryByPhoneCode('1'),
          controller: state.phoneNumberController,
          onTap: (Country value) {
            context
                .read<VfCreateeventscreen3EventadditionaldetailsBloc>()
                .add(ChangeCountryEvent(value: value));
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildPrevButton(BuildContext context) {
    return CustomElevatedButton(
        width: 106.h,
        text: "lbl_prev".tr,
        margin: EdgeInsets.only(bottom: 4.h),
        onPressed: () {
          context.read<VfCreateeventscreen3EventadditionaldetailsBloc>().add(
                SaveEventAdditionalDetailsEvent(saveIntentToDb: false),
              );
          NavigatorService.pushNamed(
              AppRoutes.vfCreateeventscreen2EventshiftsScreen);
        });
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return BlocListener<VfCreateeventscreen3EventadditionaldetailsBloc,
        VfCreateeventscreen3EventadditionaldetailsState>(
      listenWhen: (previous, current) {
        // Trigger listener only when `isSavedtoDb` changes from `false` to `true`
        return previous.isSavedtoDb != current.isSavedtoDb ||
            current.SaveDbIntent != previous.SaveDbIntent ||
            current.isSaved != previous.isSaved;
      },
      listener: (context, state) {
        if (state.isSaved && !state.isSavedtoDb && state.SaveDbIntent) {
          print('Save to db called');
          final orgEvent = _handleEventDetails(context);
          if (orgEvent != null) {
            context
                .read<VfCreateeventscreen3EventadditionaldetailsBloc>()
                .add(SaveEventShiftstoDbEvent(orgEvent: orgEvent));
          }
        }
        if (state.isSavedtoDb) {
          NavigatorService.pushNamed(AppRoutes.vfHomescreenContainerScreen);
        }
      },
      child: CustomElevatedButton(
        width: 106.h,
        text: "lbl_save".tr,
        alignment: Alignment.bottomCenter,
        onPressed: () {
          print('Save Button Pressed');
          context.read<VfCreateeventscreen3EventadditionaldetailsBloc>().add(
                SaveEventAdditionalDetailsEvent(saveIntentToDb: true),
              );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildEventDetailsForm(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCoordinatorNameInput(context),
          SizedBox(height: 22.h),
          _buildCoordinatorEmailInput(context),
          SizedBox(height: 22.h),
          _buildCoordinatorPhoneInput(context),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildPrevButton(context), _buildSaveButton(context)],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Navigator.pushNamed(
              navigatorKey.currentContext!, getCurrentRoute(type));
        },
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.vfHomescreenPage;
      case BottomBarEnum.Notifications:
        return "/";
      case BottomBarEnum.Schedule:
        return "/";
      case BottomBarEnum.Stats:
        return "/";
      case BottomBarEnum.Profile:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.vfHomescreenPage:
        return VfHomescreenPage.builder(context);
      default:
        return DefaultWidget();
    }
  }

  Voluevents? _handleEventDetails(BuildContext context) {
    // Fetch the orgEvent object from VfCreateeventscreen2EventdetailsScreen
    final eventDetailsBloc =
        BlocProvider.of<VfCreateeventscreen1EventdetailsBloc>(context);
    final eventDetailsState = eventDetailsBloc.state;
    final orgEvent =
        eventDetailsState.vfCreateeventscreen1EventdetailsModelObj?.orgEvent;
    print('eventDetailsState: ');
    // Check if isSaved is true
    if (eventDetailsState.isSaved) {
      // Fetch the shift object from VfCreateeventscreen2ShiftdetailsScreen
      final shiftDetailsBloc =
          BlocProvider.of<VfCreateeventscreen2EventshiftsBloc>(context);
      final shiftDetailsState = shiftDetailsBloc.state;
      print('ShiftDetailsState:');
      if (shiftDetailsState.isSaved) {
        final shifts = shiftDetailsState
                .vfCreateeventscreen2EventshiftsModelObj?.eventShifts ??
            [];

        final EventAdditionalDetails =
            BlocProvider.of<VfCreateeventscreen3EventadditionaldetailsBloc>(
                context);
        final EventAdditionalDetailsState = EventAdditionalDetails.state;
        final coordinator = EventAdditionalDetailsState
            .vfCreateeventscreen3EventadditionaldetailsModelObj?.coordinator;
        final eventDescription = EventAdditionalDetailsState
            .vfCreateeventscreen3EventadditionaldetailsModelObj?.description;

        if (EventAdditionalDetailsState.isSaved) {
          print('EventAdditionalDetailsState:');
          // Create a local orgEvent object of type Voluevents
          final Voluevents localOrgEvent = Voluevents(
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
          // Return the localOrgEvent object
          print('localOrgEvent: $localOrgEvent');
          return localOrgEvent;
        } else {
          print('Event Additional Details are not saved.');
        }
      } else {
        print('Shifts are not saved.');
      }
    } else {
      print('Event Details are not saved.');
    }
    return null;
  }
}
