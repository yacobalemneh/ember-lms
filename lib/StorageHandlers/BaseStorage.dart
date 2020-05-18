

abstract class BaseStorage<T> {
  static String storageURL = 'gs://ember-11eb1.appspot.com';
  Future<String> putData(T data, String fileName, String storageLocation);
}