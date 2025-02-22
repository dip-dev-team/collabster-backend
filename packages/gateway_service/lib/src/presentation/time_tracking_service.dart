import 'package:grpc/grpc.dart';
import 'package:injectable/injectable.dart';

import '../generated/base_models.pb.dart';
import '../generated/gate_models.pb.dart' as gate;
import '../generated/gate_service.pbgrpc.dart';
import '../generated/google/protobuf/empty.pb.dart';
import '../generated/time_tracking_models.pb.dart';
import '../generated/time_tracking_service.pbgrpc.dart';
import '../generated/user_service.pbgrpc.dart';

@singleton
class TimeTrackingService extends TimeTrackingGateServiceBase {
  final TimeTrackingServiceClient _timeTrackingClient;
  final UserServiceClient _userClient;

  TimeTrackingService(this._timeTrackingClient, this._userClient);

  @override
  Future<TimeTrackReply> getTimeTrack(ServiceCall call, IdRequest request) =>
      _timeTrackingClient.getTimeTrack(request,
          options: CallOptions(metadata: call.clientMetadata));

  @override
  Future<TimeTracksReply> getTimeTracks(
          ServiceCall call, gate.FilterRequest request) =>
      _userClient
          .getUser(Empty(), options: CallOptions(metadata: call.clientMetadata))
          .then((user) => _timeTrackingClient.getTimeTracks(FilterRequest(
              userId: user.id,
              pagination: request.pagination,
              dateRange: request.dateRange,
              search: request.search)));

  @override
  Future<TimeTrackReply> addTimeTrack(
          ServiceCall call, gate.AddTimeTrackRequest request) =>
      _userClient
          .getUser(Empty(), options: CallOptions(metadata: call.clientMetadata))
          .then((user) => _timeTrackingClient.addTimeTrack(AddTimeTrackRequest(
              userId: user.id,
              taskId: request.taskId,
              title: request.title,
              description: request.description)));

  @override
  Future<TimeTrackReply> updateTimeTrack(
          ServiceCall call, UpdateTimeTrackRequest request) =>
      _timeTrackingClient.updateTimeTrack(
          UpdateTimeTrackRequest(
            id: request.id,
            taskId: request.taskId,
            title: request.title,
            description: request.description,
          ),
          options: CallOptions(metadata: call.clientMetadata));

  @override
  Future<Empty> deleteTimeTrack(ServiceCall call, IdRequest request) =>
      _timeTrackingClient.deleteTimeTrack(request,
          options: CallOptions(metadata: call.clientMetadata));

  @override
  Future<TracksReply> getTracks(ServiceCall call, gate.FilterRequest request) =>
      _userClient
          .getUser(Empty(), options: CallOptions(metadata: call.clientMetadata))
          .then((user) => _timeTrackingClient.getTracks(
              FilterRequest(
                  userId: user.id,
                  dateRange: request.dateRange,
                  pagination: request.pagination,
                  search: request.search),
              options: CallOptions(metadata: call.clientMetadata)));

  @override
  Future<TimeTrackReply> startTrack(ServiceCall call, IdRequest request) =>
      _timeTrackingClient.startTrack(request,
          options: CallOptions(metadata: call.clientMetadata));

  @override
  Future<TimeTrackReply> stopTrack(ServiceCall call, IdRequest request) =>
      _timeTrackingClient.stopTrack(request,
          options: CallOptions(metadata: call.clientMetadata));

  @override
  Future<TimeTrackReply> deleteTrack(
          ServiceCall call, DeleteTrackRequest request) =>
      _timeTrackingClient.deleteTrack(request,
          options: CallOptions(metadata: call.clientMetadata));
}
