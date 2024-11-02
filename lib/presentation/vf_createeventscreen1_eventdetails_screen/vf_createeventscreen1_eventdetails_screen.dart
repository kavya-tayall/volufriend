import 'package:flutter/material.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';

import 'package:volufriend/widgets/vf_app_bar_with_title_back_button.dart';
import '../../core/app_export.dart';
import '../../core/utils/date_time_utils.dart';
import '../../data/models/selectionPopupModel/selection_popup_model.dart';

import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';
import '../vf_homescreen_page/vf_homescreen_page.dart';
import 'bloc/vf_createeventscreen1_eventdetails_bloc.dart';
import 'models/vf_createeventscreen1_eventdetails_model.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import '../../auth/bloc/login_user_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

// ignore_for_file: must_be_immutable
class VfCreateeventscreen1EventdetailsScreen extends StatelessWidget {
  VfCreateeventscreen1EventdetailsScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final controller = MultiSelectController<EventHostingType>();

  static Widget builder(BuildContext context) {
    return BlocConsumer<orgVoluEventBloc, orgVoluEventState>(
      listener: (context, orgEventState) {
        // You can listen for specific state changes here
        print('Event details screen state: $orgEventState');

        // You can also listen for other changes, like create mode or edit mode
        if (orgEventState.isLoading) {
          print('Create mode started');
          // Example: You can show a message or open a form here
        }
      },
      builder: (context, orgEventState) {
        String formContext = '';

        // Access state properties
        final eventId =
            orgEventState.eventId ?? ''; // Ensure non-null value for eventId
        //final isEditModeStarted = orgEventState.eventIdInEditModeStarted;
        final isCreateMode = orgEventState.isLoading;
        // final isViewMode = orgEventState.eventIdInDetailsViewMode;
        print(orgEventState);

        if (isCreateMode) {
          print('Create mode started');
          formContext = 'create';
        } else {
          print('Create mode not started');
          formContext = 'edit';
        }

        // Determine form context based on state
        /*
        if (isEditModeStarted) {
          formContext = 'edit';
        } else if (isCreateMode) {
          formContext = 'create';
        } else if (isViewMode) {
          formContext = 'view';
        }*/

        // Debugging print statements
        print('eventId: $eventId');
        print('formContext: $formContext');

        final userBloc = BlocProvider.of<UserBloc>(context);
        final userState = userBloc.state;
        print(userState);
        if (userState is LoginUserWithHomeOrg) {
          print('User is logged in with home org');
          final userHomeOrg = userState.user.userHomeOrg;
          final String? orgId = userHomeOrg?.orgid;
          final String? usrorgid = userHomeOrg?.useridinorg;
          final String? parentorgid = userHomeOrg?.parentorg;
          final String? orgname = userHomeOrg?.orgname;

          context.read<VfCreateeventscreen1EventdetailsBloc>().add(
                VfCreateeventscreen1EventdetailsInitialEvent(
                  eventId: eventId,
                  formContext: formContext,
                  orgId: orgId,
                  useridinorg: usrorgid,
                  parentOrg: parentorgid,
                  orgName: orgname,
                ),
              );
        }
        return VfCreateeventscreen1EventdetailsScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: VfAppBarWithTitleBackButton(
          title: "Create Event",
          showSearchIcon: false,
          showFilterIcon: false,
          onBackPressed: () {
            Navigator.of(context).pop();
          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.h),
          child: Container(
            decoration: AppDecoration.surface.copyWith(
              borderRadius: BorderRadius.circular(12.h),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16.h),
                  decoration: AppDecoration.fillGray.copyWith(
                    borderRadius: BorderRadius.circular(12.h),
                  ),
                  child: Column(
                    children: [
                      _buildEventHostingTypeMultiselect(context, controller),
                      SizedBox(height: 20.h),
                      _buildTitleInput(context),
                      SizedBox(height: 20.h),
                      BlocSelector<
                          VfCreateeventscreen1EventdetailsBloc,
                          VfCreateeventscreen1EventdetailsState,
                          VfCreateeventscreen1EventdetailsModel?>(
                        selector: (state) =>
                            state.vfCreateeventscreen1EventdetailsModelObj,
                        builder: (context, model) {
                          List<SelectionPopupModel> items = model?.causesList
                                  .map((cause) => SelectionPopupModel(
                                        id: cause.id,
                                        title: cause.name!,
                                      ))
                                  .toList() ??
                              [];
                          final selectedValue = context
                              .read<VfCreateeventscreen1EventdetailsBloc>()
                              .state
                              .selectedCausesDropDownValue;
                          SelectionPopupModel? initialValue;
                          if (selectedValue != null) {
                            initialValue = items.firstWhere(
                              (item) => item.id == selectedValue.id,
                              orElse: () =>
                                  SelectionPopupModel(id: '', title: ''),
                            );
                          }
                          return CustomDropDown(
                            width: double.infinity,
                            icon: Padding(
                              padding: EdgeInsets.only(left: 12.h),
                              child: CustomImageView(
                                imagePath:
                                    ImageConstant.imgIcarrowdropdown48pxPrimary,
                                height: 24.h,
                                width: 24.h,
                              ),
                            ),
                            hintText: "lbl_cause".tr,
                            alignment: Alignment.centerLeft,
                            items: items,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.h,
                              vertical: 18.h,
                            ),
                            onChanged: (value) {
                              context
                                  .read<VfCreateeventscreen1EventdetailsBloc>()
                                  .add(UpdateCausesDropDownSelectionEvent(
                                      value));
                            },
                            initialValue:
                                initialValue?.id == '' ? null : initialValue,
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      _buildVenueInput(context),
                      SizedBox(height: 20.h),
                      _buildDateRow(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.h),
          child: CustomElevatedButton(
            width: 120.h,
            text: "lbl_next".tr,
            onPressed: () {
              final OrgProfileBloc =
                  context.read<VfCreateeventscreen1EventdetailsBloc>();
              OrgProfileBloc.add(SaveEventDetailsEvent());
              NavigatorService.pushNamed(
                AppRoutes.vfCreateeventscreen2EventshiftsScreen,
              );
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTitleInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen1EventdetailsBloc,
        VfCreateeventscreen1EventdetailsState, TextEditingController?>(
      selector: (state) => state.titleInputController,
      builder: (context, controller) {
        return CustomFloatingTextField(
          controller: controller,
          labelText: "lbl_title".tr,
          labelStyle: theme.textTheme.bodyLarge,
          hintText: "lbl_title".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildVenueInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen1EventdetailsBloc,
        VfCreateeventscreen1EventdetailsState, TextEditingController?>(
      selector: (state) => state.venueInputController,
      builder: (context, controller) {
        return CustomFloatingTextField(
          controller: controller,
          labelText: "lbl_event_venue".tr,
          labelStyle: theme.textTheme.bodyLarge,
          hintText: "lbl_event_venue".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildEventDateInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen1EventdetailsBloc,
        VfCreateeventscreen1EventdetailsState, TextEditingController?>(
      selector: (state) => state.eventDateInputController,
      builder: (context, eventDateInputController) {
        return CustomFloatingTextField(
          controller: eventDateInputController,
          labelText: "lbl_event_date".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "lbl_event_date".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
          onTap: () {
            onTapEventDateInput(context);
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildRegistrationDeadlineInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen1EventdetailsBloc,
        VfCreateeventscreen1EventdetailsState, TextEditingController?>(
      selector: (state) => state.registrationDeadlineInputController,
      builder: (context, registrationDeadlineInputController) {
        return CustomFloatingTextField(
          controller: registrationDeadlineInputController,
          labelText: "msg_registration_deadline".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_registration_deadline".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
          onTap: () {
            onTapRegDateInput(context);
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildDateRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildEventDateInput(context)),
        SizedBox(width: 12.h), // Spacing between the two date inputs
        Expanded(child: _buildRegistrationDeadlineInput(context)),
      ],
    );
  }

  /// Section Widget
  /// Section Widget
  /// Section Widget
  Widget _buildNextButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32.h, bottom: 16.h),
      child: Center(
        // Center aligns the button
        child: CustomElevatedButton(
          width: 120.h, // Ensures button width consistency
          text: "lbl_next".tr,
          onPressed: () {
            final OrgProfileBloc =
                context.read<VfCreateeventscreen1EventdetailsBloc>();
            OrgProfileBloc.add(SaveEventDetailsEvent());
            NavigatorService.pushNamed(
              AppRoutes.vfCreateeventscreen2EventshiftsScreen,
            );
          },
        ),
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

  /// Displays a date picker dialog and updates the selected date in the
  /// current [vfCreateeventscreen1EventdetailsModelObj] object if the user selects a valid date.
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> onTapEventDateInput(BuildContext context) async {
    var initialState =
        BlocProvider.of<VfCreateeventscreen1EventdetailsBloc>(context).state;

    DateTime now = DateTime.now();
    DateTime oneYearFromNow = DateTime(now.year + 1, now.month, now.day);

    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Allow selection from today
      lastDate: oneYearFromNow, // Allow selection up to one year from today
    );

    if (dateTime != null) {
      context
          .read<VfCreateeventscreen1EventdetailsBloc>()
          .add(ChangeEventDateEvent(date: dateTime));

      // Update the text field with the selected date
      initialState.eventDateInputController?.text =
          dateTime.format(pattern: dateTimeFormatPattern);
    }
  }

  Future<void> onTapRegDateInput(BuildContext context) async {
    var initialState =
        BlocProvider.of<VfCreateeventscreen1EventdetailsBloc>(context).state;

    DateTime now = DateTime.now();
    DateTime oneYearFromNow = DateTime(now.year + 1, now.month, now.day);

    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Allow selection from today
      lastDate: oneYearFromNow, // Allow selection up to one year from today
    );

    if (dateTime != null) {
      context
          .read<VfCreateeventscreen1EventdetailsBloc>()
          .add(ChangeEventRegistrationByDateEvent(date: dateTime));

      // Update the text field with the selected date
      initialState.registrationDeadlineInputController?.text =
          dateTime.format(pattern: dateTimeFormatPattern);
    }
  }

  Widget _buildEventHostingTypeMultiselect(BuildContext context,
      MultiSelectController<EventHostingType> controller) {
    return SizedBox(
      height: 64.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 12.h,
            ),
            decoration: AppDecoration.outlinePrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: BlocSelector<
                VfCreateeventscreen1EventdetailsBloc,
                VfCreateeventscreen1EventdetailsState,
                VfCreateeventscreen1EventdetailsModel?>(
              selector: (state) {
                return state.vfCreateeventscreen1EventdetailsModelObj;
              },
              builder: (context, vfCreateeventscreen1EventdetailsModelObj) {
                // Check if the data is still loading or empty
                if (vfCreateeventscreen1EventdetailsModelObj == null) {
                  return Center(
                    child: Text("Loading event hosting options..."),
                  );
                }

                if (vfCreateeventscreen1EventdetailsModelObj
                    .eventhostingoptions.isEmpty) {
                  return Center(
                    child: Text("No event hosting options available."),
                  );
                }

                // Extract selected hosting options from the model object
                final selectedMultiSelectValuesforEventHostingOptions = context
                    .read<VfCreateeventscreen1EventdetailsBloc>()
                    .state
                    .selectedEventHostingOptionDropDownValue;

                // Convert event hosting options to dropdown items
                List<DropdownItem<EventHostingType>> items =
                    vfCreateeventscreen1EventdetailsModelObj.eventhostingoptions
                        .map((eventHostingType) => DropdownItem(
                              label: eventHostingType.option!,
                              value: eventHostingType,
                            ))
                        .toList();

                // Convert preselected hosting options to dropdown items
                List<DropdownItem<EventHostingType>> preSelectItems =
                    selectedMultiSelectValuesforEventHostingOptions
                            ?.map((eventHostingType) => DropdownItem(
                                  label: eventHostingType.option!,
                                  value: eventHostingType,
                                ))
                            .toList() ??
                        [];

                // Initialize the controller with preselected options
                if (controller.selectedItems.isEmpty &&
                    preSelectItems.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final preSelectCauseIds =
                        preSelectItems.map((item) => item.value.id).toSet();
                    controller.selectWhere((element) =>
                        preSelectCauseIds.contains(element.value.id));
                  });
                }

                return MultiDropdown<EventHostingType>(
                  items: items,
                  controller: controller,
                  enabled: true,
                  searchEnabled: false,
                  chipDecoration: ChipDecoration(
                    backgroundColor: Colors.white,
                    wrap: true,
                    runSpacing: 4.h,
                    spacing: 6.h,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fieldDecoration: FieldDecoration(
                    hintText: 'Select Event Hosting Options',
                    hintStyle: theme.textTheme.bodySmall,
                    showClearIcon: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  dropdownDecoration: DropdownDecoration(
                    marginTop: 8,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onSelectionChange: (selectedItems) {
                    print('Selected value: $selectedItems'); // Debug print
                    context.read<VfCreateeventscreen1EventdetailsBloc>().add(
                          UpdateEventHostingOptionsEvent(selectedItems),
                        );
                  },
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 4.h),
              decoration: AppDecoration.surface,
              child: Text(
                "lbl_event_type".tr,
                textAlign: TextAlign.center,
                style: CustomTextStyles.bodySmallRobotoPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
