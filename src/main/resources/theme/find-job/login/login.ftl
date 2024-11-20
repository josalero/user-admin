
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
<div id="root">
   <div class="flex min-h-screen flex-col justify-center px-6 py-12 lg:px-8">
      <div class="max-w-[320px] w-full m-auto">
         <div class="sm:mx-auto w-full">
            <img src="${url.resourcesPath}/img/logo.png" alt="plantripsai-logo" class="logo-img-card">
            <h2 class="mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900">Sign in to your account</h2>
         </div>
         <form action="${url.loginAction}" method="post">
             <div class="mt-10 sm:mx-auto w-full">
                <div class="space-y-6">
                       <div>
                          <label for="email" class="block text-sm/6 font-medium text-gray-900">User</label>
                          <div class="mt-2"><input name="username" type="text" placeholder="Enter your username..." class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm/6 px-3" ></div>
                       </div>
                       <div>
                          <div class="flex items-center justify-between">
                             <label for="password" class="block text-sm/6 font-medium text-gray-900">Password</label>
                             <div class="text-sm"><a href="${url.loginResetCredentialsUrl} class="font-semibold text-indigo-600 hover:text-indigo-500">Forgot password?</a></div>
                          </div>
                          <div class="mt-2"><input id="input-password" name="password" type="password" autocomplete="current-password" required="" placeholder="Enter your password..." class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm/6 px-3" value=""></div>
                       </div>
                        <#if messagesPerField.existsError('username','password')>
                            <div class="text-sm">${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}</div>
                        </#if>
                   <div><button type="submit" class="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">Sign in</button></div>
                </div>
             </div>
        </form>
      </div>
   </div>
</div>
</@layout.registrationLayout>