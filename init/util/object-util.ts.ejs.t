---
to: <%= rootDirectory %>/api/src/app/util/object-util.ts
force: true
---
/**
 * Copy matching fields from source to target.
 * @param source
 * @param target
*/
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

  /**
   * Patch matching fields from source to target.
   * @param source
   * @param target
  */
  static patchMatchingFields(source: any, target: any) {
    Object.getOwnPropertyNames(source).forEach((key) => {
      const value = source[key];
      if (
        value !== null &&
        ['string', 'number', 'boolean', 'symbol', 'bigint'].includes(
          typeof value,
        )
      ) {
        target[key] = value;
      }
    });
  }

  /**
   * Convert orderBy string to FindOptionsOrder object.
   * orderBy = 'id,-email'
   * return { id: 'ASC', email: 'DESC' }
   */
  static convertOrdersToMap(condition: BaseSearchCondition) {
    if (!condition.orderBy) {
      return {};
    }
    const orders = condition.orderBy.split(',');
    const order = {};
    for (const o of orders) {
      const key = o.replace(/^-/, '');
      order[key] = o.startsWith('-') ? 'DESC' : 'ASC';
    }
    return order;
  }
}
