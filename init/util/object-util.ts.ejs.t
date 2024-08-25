---
to: <%= rootDirectory %>/api/src/app/util/object-util.ts
force: true
---
export default class ObjectUtil {
  static copyMatchingFields(source: any, target: any) {
    Object.getOwnPropertyNames(source).forEach((key) => {
      const value = source[key];
      if (
        value === null ||
        [
          'string',
          'number',
          'boolean',
          'symbol',
          'bigint',
          'undefined',
        ].includes(typeof value)
      ) {
        target[key] = value;
      }
    });
  }
}