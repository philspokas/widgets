using IntelliTect.Coalesce;
using IntelliTect.Coalesce.Mapping;
using IntelliTect.Coalesce.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;

namespace Phil.Widgets.Web.Models
{
    public partial class UserInfoParameter : GeneratedParameterDto<Phil.Widgets.Data.Auth.UserInfo>
    {
        public UserInfoParameter() { }

        private string _Id;
        private string _UserName;

        public string Id
        {
            get => _Id;
            set { _Id = value; Changed(nameof(Id)); }
        }
        public string UserName
        {
            get => _UserName;
            set { _UserName = value; Changed(nameof(UserName)); }
        }

        /// <summary>
        /// Map from the current DTO instance to the domain object.
        /// </summary>
        public override void MapTo(Phil.Widgets.Data.Auth.UserInfo entity, IMappingContext context)
        {
            var includes = context.Includes;

            if (OnUpdate(entity, context)) return;

            if (ShouldMapTo(nameof(Id))) entity.Id = Id;
            if (ShouldMapTo(nameof(UserName))) entity.UserName = UserName;
        }

        /// <summary>
        /// Map from the current DTO instance to a new instance of the domain object.
        /// </summary>
        public override Phil.Widgets.Data.Auth.UserInfo MapToNew(IMappingContext context)
        {
            var entity = new Phil.Widgets.Data.Auth.UserInfo();
            MapTo(entity, context);
            return entity;
        }
    }

    public partial class UserInfoResponse : GeneratedResponseDto<Phil.Widgets.Data.Auth.UserInfo>
    {
        public UserInfoResponse() { }

        public string Id { get; set; }
        public string UserName { get; set; }

        /// <summary>
        /// Map from the domain object to the properties of the current DTO instance.
        /// </summary>
        public override void MapFrom(Phil.Widgets.Data.Auth.UserInfo obj, IMappingContext context, IncludeTree tree = null)
        {
            if (obj == null) return;
            var includes = context.Includes;

            this.Id = obj.Id;
            this.UserName = obj.UserName;
        }
    }
}
