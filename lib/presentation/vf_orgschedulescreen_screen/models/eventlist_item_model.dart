/// This class is used in the [eventlist_item_widget] screen.

// ignore_for_file: must_be_immutable
class EventlistItemModel {
  EventlistItemModel(
      {this.h3,
      this.h3One,
      this.access,
      this.h3Two,
      this.accessOne,
      this.h3Three,
      this.h3Four,
      this.id}) {
    h3 = h3 ?? "xxam-xxpm";
    h3One = h3One ?? "Event #1";
    access = access ?? "SUBHEADING";
    h3Two = h3Two ?? "Lorem ipsum";
    accessOne = accessOne ?? "SUBHEADING";
    h3Three = h3Three ?? "Lorem ipsum";
    h3Four = h3Four ?? ">";
    id = id ?? "";
  }

  String? h3;

  String? h3One;

  String? access;

  String? h3Two;

  String? accessOne;

  String? h3Three;

  String? h3Four;

  String? id;
}
