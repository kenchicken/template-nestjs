---
to: <%= rootDirectory %>/api/src/app/util/object-util.ts
force: true
---
export default class ObjectUtil {
  static copyMatchingFields(source: any, target: any) {
    Object.keys(source).forEach((key) => {
      if (key in target) {
        target[key] = source[key];
      }
    });
  }
}
