---
to: <%= rootDirectory %>/api/src/app/util/object-util.ts
force: true
---
export default class ObjectUtil {
  static copyMatchingFields(source: any, target: any) {
    Object.getOwnPropertyNames(source).forEach((key) => {
      target[key] = source[key];
    });
  }
}
