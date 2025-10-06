<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
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
                Two-Factor Authentication
            </h2>
            <p class="mt-2 text-center text-sm text-gray-600">
                Enter the verification code from your authenticator app
            </p>
         </div>
         <form action="${url.loginAction}" method="post" class="mt-8 w-full space-y-8">
             <div class="space-y-6">
                 <div>
                     <input 
                         id="totp" 
                         name="totp" 
                         type="text" 
                         autocomplete="off"
                         placeholder="000000"
                         maxlength="6" 
                         pattern="[0-9]{6}"
                         autofocus
                         class="block w-full rounded-md border-0 py-3 px-4 text-gray-900 text-center text-lg font-mono tracking-widest shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:text-lg"
                     />
                     <p class="mt-2 text-xs text-gray-500 text-center">
                         Open your authenticator app and enter the 6-digit code
                     </p>
                     <#if messagesPerField.existsError('totp')>
                         <div class="mt-2 text-sm text-red-600 text-center">
                             ${kcSanitize(messagesPerField.getFirstError('totp'))?no_esc}
                         </div>
                     </#if>
                 </div>
                 
                 <button 
                     type="submit" 
                     class="flex w-full justify-center rounded-md bg-blue-600 px-3 py-1.5 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600 disabled:bg-blue-100 disabled:cursor-not-allowed"
                 >
                     Verify Code
                 </button>
             </div>

             <div class="mt-6">
                 <a 
                     href="${url.loginUrl}" 
                     class="text-sm text-blue-600 hover:text-blue-500"
                 >
                     ← Back to Login
                 </a>
             </div>
         </form>
      </div>
   </div>
</div>

<script>
// Auto-focus and format the TOTP input
document.addEventListener('DOMContentLoaded', function() {
    const totpInput = document.getElementById('totp');
    if (totpInput) {
        totpInput.focus();
        
        // Auto-submit when 6 digits are entered
        totpInput.addEventListener('input', function(e) {
            const value = e.target.value.replace(/\D/g, ''); // Remove non-digits
            e.target.value = value;
            
            if (value.length === 6) {
                // Auto-submit after a short delay
                setTimeout(() => {
                    e.target.closest('form').submit();
                }, 500);
            }
        });
        
        // Only allow numbers
        totpInput.addEventListener('keypress', function(e) {
            if (!/[0-9]/.test(e.key) && !['Backspace', 'Delete', 'Tab', 'Enter'].includes(e.key)) {
                e.preventDefault();
            }
        });
    }
});
</script>

<style>
    /* Additional styling to match React app */
    body {
        background-color: #f9fafb;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', sans-serif;
    }
    
    #totp:focus {
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
</@layout.registrationLayout>
