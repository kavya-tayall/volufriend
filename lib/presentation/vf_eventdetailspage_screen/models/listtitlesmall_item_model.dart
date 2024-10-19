/// This class is used in the [listtitlesmall_item_widget] screen.

// ignore_for_file: must_be_immutable
class ListtitlesmallItemModel {
  ListtitlesmallItemModel(
      {this.titlesmall, this.time, this.titlesmallOne, this.timeOne, this.id}) {
    titlesmall = titlesmall ?? "Tuesday, Sep 17 2024";
    time = time ?? "03:00 PM";
    titlesmallOne = titlesmallOne ?? "-";
    timeOne = timeOne ?? "05:30 PM";
    id = id ?? "";
  }

  String? titlesmall;

  String? time;

  String? titlesmallOne;

  String? timeOne;

  String? id;
}
