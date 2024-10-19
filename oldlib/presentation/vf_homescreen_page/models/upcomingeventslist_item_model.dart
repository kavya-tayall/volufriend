/// This class is used in the [upcomingeventslist_item_widget] screen.

// ignore_for_file: must_be_immutable
class UpcomingeventslistItemModel {
  UpcomingeventslistItemModel(
      {this.listItemHeadlin, this.listItemSupport, this.id}) {
    listItemHeadlin = listItemHeadlin ?? "List item";
    listItemSupport = listItemSupport ??
        "Supporting line text lorem ipsum dolor sit amet, consectetur.";
    id = id ?? "";
  }

  String? listItemHeadlin;

  String? listItemSupport;

  String? id;
}
