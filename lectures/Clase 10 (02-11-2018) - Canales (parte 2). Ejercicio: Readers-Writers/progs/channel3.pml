/* Copyright 2007 by Moti Ben-Ari under the GNU GPL; see readme.txt */

chan request = [2] of { byte, chan};
chan reply[2] = [2] of { byte };

active [2] proctype Server() {
  byte client;
  chan replyChannel;
  do
  :: empty(request) ->
       printf("No requests for server %d\n", _pid)
  :: request ? client, replyChannel ->
       printf("Client %d processed by server %d\n", client, _pid);
       replyChannel ! _pid
  od
}

active [2] proctype Client() {
  byte server;
  do
  :: nfull(request) ->
       printf("Client %d waiting for non-full channel\n", _pid)
  :: request ! _pid, reply[_pid-2] ->
       reply[_pid-2] ? server;
     printf("Reply received from server %d by client %d\n", server, _pid)
  od
}
