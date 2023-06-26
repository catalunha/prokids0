 cd ~/myapp/cemec.net.br/prokids0 && flutter build web --dart-define-from-file=lib/app/core/keys/keys.json  && cd back4app/prokids0 && b4a deploy


 @riverpod
FutureOr<bool> initDB(InitDBRef ref) async {
  final InitBack4app initBack4app = InitBack4app();
  final bool initParse = await initBack4app.init();

  return initParse;
}
