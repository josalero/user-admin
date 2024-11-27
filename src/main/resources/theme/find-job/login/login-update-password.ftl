<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
<div id="root">
   <div class="flex min-h-screen flex-col justify-center px-6 py-12 lg:px-8">
      <div class="max-w-[320px] w-full m-auto">
         <div class="sm:mx-auto w-full">
            <h2 class="mt-10 text-center text-2xl/9 font-bold tracking-tight text-gray-900">Update Password</h2>
         </div>
         <form action="${url.loginAction}" method="post">
             <input type="email" id="username" name="username" value="${username}" autocomplete="email" readonly="readonly" style="display:none;"/>
             <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>
             <div class="mt-10 sm:mx-auto w-full">
                <div class="space-y-6">
                     <div>
                          <div class="flex items-center justify-between">
                             <label for="password" class="block text-sm/6 font-medium text-gray-900">${msg("passwordNew")}</label>
                          </div>
                          <div class="mt-2">
                            <input id="password-new" name="password-new" type="password" autocomplete="current-password" required="" placeholder="Enter your password..." class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm/6 px-3" value="">
                          </div>
                       </div>
                       <div>
                          <div class="flex items-center justify-between">
                             <label for="password" class="block text-sm/6 font-medium text-gray-900">${msg("passwordConfirm")}</label>
                          </div>
                          <div class="mt-2">
                            <input id="password-confirm" name="password-confirm" type="password" autocomplete="confirm-password" required="" placeholder="Enter your password..." class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm/6 px-3" value="">
                          </div>
                       </div>
                        <#if messagesPerField.existsError('password-confirm','password')>
                            <div class="text-sm">${kcSanitize(messagesPerField.getFirstError('password-confirm','password'))?no_esc}</div>
                        </#if>
                    <div>
                    <button type="submit" class="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">Update Password</button></div>
                </div>
             </div>
        </form>
      </div>
   </div>
</div>
</@layout.registrationLayout>