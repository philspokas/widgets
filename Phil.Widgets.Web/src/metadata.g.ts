import { getEnumMeta, solidify } from 'coalesce-vue/lib/metadata'
import type {
  Domain, ModelType, ObjectType, HiddenAreas, BehaviorFlags, 
  PrimitiveProperty, ForeignKeyProperty, PrimaryKeyProperty,
  ModelCollectionNavigationProperty, ModelReferenceNavigationProperty
} from 'coalesce-vue/lib/metadata'


const domain: Domain = { enums: {}, types: {}, services: {} }
export const WidgetCategory = domain.enums.WidgetCategory = {
  name: "WidgetCategory" as const,
  displayName: "Widget Category",
  type: "enum",
  ...getEnumMeta<"Whizbangs"|"Sprecklesprockets"|"Discombobulators">([
  {
    value: 0,
    strValue: "Whizbangs",
    displayName: "Whizbangs",
  },
  {
    value: 1,
    strValue: "Sprecklesprockets",
    displayName: "Sprecklesprockets",
  },
  {
    value: 2,
    strValue: "Discombobulators",
    displayName: "Discombobulators",
  },
  ]),
}
export const Widget = domain.types.Widget = {
  name: "Widget" as const,
  displayName: "Widget",
  description: "A sample model provided by the Coalesce template. Remove this when you start building your real data model.",
  get displayProp() { return this.props.name }, 
  type: "model",
  controllerRoute: "Widget",
  get keyProp() { return this.props.widgetId }, 
  behaviorFlags: 7 as BehaviorFlags,
  props: {
    widgetId: {
      name: "widgetId",
      displayName: "Widget Id",
      type: "number",
      role: "primaryKey",
      hidden: 3 as HiddenAreas,
    },
    name: {
      name: "name",
      displayName: "Name",
      type: "string",
      role: "value",
      rules: {
        required: val => (val != null && val !== '') || "Name is required.",
      }
    },
    category: {
      name: "category",
      displayName: "Category",
      type: "enum",
      get typeDef() { return WidgetCategory },
      role: "value",
      rules: {
        required: val => val != null || "Category is required.",
      }
    },
    inventedOn: {
      name: "inventedOn",
      displayName: "Invented On",
      type: "date",
      dateKind: "datetime",
      role: "value",
    },
    modifiedById: {
      name: "modifiedById",
      displayName: "Modified By Id",
      type: "string",
      role: "value",
      dontSerialize: true,
    },
    createdById: {
      name: "createdById",
      displayName: "Created By Id",
      type: "string",
      role: "value",
      dontSerialize: true,
    },
    createdOn: {
      name: "createdOn",
      displayName: "Created On",
      type: "date",
      dateKind: "datetime",
      role: "value",
      dontSerialize: true,
    },
    modifiedOn: {
      name: "modifiedOn",
      displayName: "Modified On",
      type: "date",
      dateKind: "datetime",
      role: "value",
      dontSerialize: true,
    },
  },
  methods: {
  },
  dataSources: {
  },
}
export const UserInfo = domain.types.UserInfo = {
  name: "UserInfo" as const,
  displayName: "User Info",
  type: "object",
  props: {
    id: {
      name: "id",
      displayName: "Id",
      type: "string",
      role: "value",
    },
    userName: {
      name: "userName",
      displayName: "User Name",
      type: "string",
      role: "value",
    },
  },
}
export const SecurityService = domain.services.SecurityService = {
  name: "SecurityService",
  displayName: "Security Service",
  type: "service",
  controllerRoute: "SecurityService",
  methods: {
    whoAmI: {
      name: "whoAmI",
      displayName: "Who AmI",
      transportType: "item",
      httpMethod: "GET",
      params: {
      },
      return: {
        name: "$return",
        displayName: "Result",
        type: "object",
        get typeDef() { return (domain.types.UserInfo as ObjectType & { name: "UserInfo" }) },
        role: "value",
      },
    },
  },
}

interface AppDomain extends Domain {
  enums: {
    WidgetCategory: typeof WidgetCategory
  }
  types: {
    UserInfo: typeof UserInfo
    Widget: typeof Widget
  }
  services: {
    SecurityService: typeof SecurityService
  }
}

solidify(domain)

export default domain as unknown as AppDomain
