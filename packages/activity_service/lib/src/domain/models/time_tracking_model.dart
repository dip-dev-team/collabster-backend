import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../generated/google/protobuf/timestamp.pb.dart';
import '../../generated/time_tracking_models.pb.dart';

part 'time_tracking_model.g.dart';

abstract class TimeTrackingModel
    implements Built<TimeTrackingModel, TimeTrackingModelBuilder> {
  int? get id;
  int get userId;
  int? get taskId;
  String? get title;
  String? get description;
  BuiltList<TrackModel> get tracks;

  TimeTrackingModel._();
  factory TimeTrackingModel([void Function(TimeTrackingModelBuilder) updates]) =
      _$TimeTrackingModel;

  TimeTrackReply toReply() => TimeTrackReply(
      id: id,
      userId: userId,
      taskId: taskId,
      title: title,
      description: description,
      tracks: tracks.map((p0) => p0.toReply()));
}

abstract class TrackModel implements Built<TrackModel, TrackModelBuilder> {
  int? get id;
  DateTime get start;
  DateTime? get end;

  TrackModel._();
  factory TrackModel([void Function(TrackModelBuilder) updates]) = _$TrackModel;

  TrackReply toReply() => TrackReply(
      id: id,
      start: Timestamp.fromDateTime(start),
      end: end != null ? Timestamp.fromDateTime(end!) : null);
}
