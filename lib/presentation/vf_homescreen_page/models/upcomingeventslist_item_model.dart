/// This class is used in the [upcomingeventslist_item_widget] screen.

// ignore_for_file: must_be_immutable
class UpcomingeventslistItemModel {
  UpcomingeventslistItemModel({
    this.listItemHeadlin,
    this.listItemSupport,
    this.id,
    this.isSelected,
    this.isCompleted,
    this.isCanceled,
  }) {
    listItemHeadlin = listItemHeadlin ?? "List item3";
    listItemSupport = listItemSupport ??
        "Supporting line text lorem ipsum dolor sit amet, consectetur.";
    id = id ?? "";
    isSelected = isSelected ?? false;
    isCompleted = isCompleted ?? false;
    isCanceled = isCanceled ?? false;
  }

  String? listItemHeadlin;
  String? listItemSupport;
  String? id;
  bool? isSelected;
  bool? isCompleted;
  bool? isCanceled;

  // Define the copyWith method
  UpcomingeventslistItemModel copyWith({
    String? listItemHeadlin,
    String? listItemSupport,
    String? id,
    bool? isSelected,
    bool? isCompleted,
    bool? isCanceled,
  }) {
    return UpcomingeventslistItemModel(
      listItemHeadlin: listItemHeadlin ?? this.listItemHeadlin,
      listItemSupport: listItemSupport ?? this.listItemSupport,
      id: id ?? this.id,
      isSelected: isSelected ?? this.isSelected,
      isCompleted: isCompleted ?? this.isCompleted,
      isCanceled: isCanceled ?? this.isCanceled,
    );
  }
}