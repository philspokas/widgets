import { SecurityServiceViewModel } from "@/viewmodels.g";
import { UserInfo } from "@/models.g";

const securityService = new SecurityServiceViewModel();
securityService.whoAmI.setConcurrency("debounce");

/** Properties about the currently authenticated user */
export const userInfo = computed(() => {
  return securityService.whoAmI.result ?? new UserInfo();
});

export const refreshUserInfo = () => securityService.whoAmI();

const interval = 1000 * 60 * 5; // Refresh every X minutes.
setInterval(() => {
  // Don't refresh user info if the window is minimized or the tab is in the background.
  if (!document.hidden) {
    refreshUserInfo().catch();
  }
}, interval);

// Reload user info on window focus.
document.addEventListener(
  "visibilitychange",
  () => {
    if (!document.hidden) refreshUserInfo();
  },
  false,
);

// Make useful properties available in vue <template>s
declare module "vue" {
  interface ComponentCustomProperties {
    $userInfo: (typeof userInfo)["value"];
  }
}
export const globalProperties = {
  get $userInfo() {
    return userInfo.value;
  },
};
