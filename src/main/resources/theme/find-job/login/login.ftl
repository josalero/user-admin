
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
<div id="root">
    <div class="flex min-h-screen flex-col justify-center px-6 py-12 lg:px-8">
        <div class="max-w-[320px] w-full m-auto bg-white p-8 rounded-lg shadow-[0_0_0_1px_rgba(0,0,0,0.1),0_4px_12px_rgba(0,0,0,0.15)]">
            
            <div class="sm:mx-auto w-full">
                <img
                    class="mx-auto h-14 w-auto"
                    src="${url.resourcesPath}/img/logo.png"
                    alt="Logo"
                />
                <h2 class="mt-4 text-center text-2xl font-bold tracking-tight text-gray-900">
                    Sign in to your account
                </h2>
            </div>

            <form action="${url.loginAction}" method="post" class="mt-8 w-full space-y-8">
                <div class="space-y-6">
                    <div>
                        <input 
                            id="username"
                            name="username" 
                            type="text" 
                            <#if usernameEditDisabled??>disabled</#if>
                            placeholder="Username"
                            <#if login.username??>value="${(login.username!'')}"</#if>
                            tabindex="1"
                            autofocus
                            autocomplete="off"
                            class="block w-full rounded-md border-0 py-3 px-4 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm"
                        />
                    </div>
                    
                    <div>
                        <input 
                            id="password"
                            name="password" 
                            type="password" 
                            placeholder="Password"
                            tabindex="2"
                            autocomplete="current-password"
                            class="block w-full rounded-md border-0 py-3 px-4 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-sm"
                        />
                    </div>

                    <#if realm.rememberMe && !usernameEditDisabled??>
                        <div class="flex items-center">
                            <input 
                                id="rememberMe" 
                                name="rememberMe" 
                                type="checkbox" 
                                tabindex="3"
                                <#if login.rememberMe??>checked</#if>
                                class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded"
                            />
                            <label for="rememberMe" class="ml-2 block text-sm text-gray-900">
                                ${msg("rememberMe")}
                            </label>
                        </div>
                    </#if>

                    <#if messagesPerField.existsError('username','password')>
                        <div class="rounded-md bg-red-50 p-4">
                            <div class="text-sm text-red-800">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </div>
                        </div>
                    </#if>
                    
                    <button 
                        type="submit" 
                        name="login"
                        id="kc-login"
                        tabindex="4"
                        class="flex w-full justify-center rounded-md bg-blue-600 px-3 py-1.5 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600 disabled:bg-blue-100 disabled:cursor-not-allowed"
                    >
                        ${msg("doLogIn")}
                    </button>
                </div>

                <div class="mt-6">
                    <#if realm.resetPasswordAllowed>
                        <a 
                            href="${url.loginResetCredentialsUrl}" 
                            class="text-sm text-blue-600 hover:text-blue-500"
                            tabindex="5"
                        >
                            ${msg("doForgotPassword")}
                        </a>
                    </#if>
                </div>

                <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                    <div class="mt-6 text-center">
                        <span class="text-sm text-gray-600">
                            ${msg("noAccount")}
                            <a 
                                href="${url.registrationUrl}" 
                                class="font-medium text-blue-600 hover:text-blue-500"
                                tabindex="6"
                            >
                                ${msg("doRegister")}
                            </a>
                        </span>
                    </div>
                </#if>
            </form>
        </div>
    </div>
</div>

<style>
    /* Additional styling to match React app */
    body {
        background-color: #f9fafb;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
    }
    
    input:focus {
        box-shadow: 0 0 0 2px rgb(37 99 235 / 0.2);
    }
    
    /* Loading state for button */
    button[type="submit"]:active {
        transform: scale(0.98);
        transition: transform 0.1s;
    }
    
    /* Ensure the card stands out on the background */
    .shadow-\[0_0_0_1px_rgba\(0\,0\,0\,0\.1\)\,0_4px_12px_rgba\(0\,0\,0\,0\.15\)\] {
        box-shadow: 0 0 0 1px rgba(0,0,0,0.1), 0 4px 12px rgba(0,0,0,0.15);
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Focus on username field if empty, otherwise focus on password
        const usernameField = document.getElementById('username');
        const passwordField = document.getElementById('password');
        
        if (usernameField && passwordField) {
            if (usernameField.value.trim() === '') {
                usernameField.focus();
            } else {
                passwordField.focus();
            }
            
            // Handle Enter key navigation
            usernameField.addEventListener('keydown', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    passwordField.focus();
                }
            });
            
            passwordField.addEventListener('keydown', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    document.getElementById('kc-login').click();
                }
            });
        }
    });
</script>
</@layout.registrationLayout>