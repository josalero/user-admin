<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp','totpSecret') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
<div id="root">
   <div class="flex min-h-screen flex-col justify-center px-6 py-12 lg:px-8">
      <div class="max-w-[240px] w-full m-auto bg-white p-8 rounded-lg shadow-[0_0_0_1px_rgba(0,0,0,0.1),0_4px_12px_rgba(0,0,0,0.15)]">
         
         <div class="sm:mx-auto w-full">
            <img
                class="mx-auto h-14 w-auto logo-size"
                src="${url.resourcesPath}/img/logo.png"
                alt="Logo"
            />
            <h2 class="mt-4 text-center text-2xl font-bold tracking-tight text-gray-900">
                Setup Two-Factor Authentication
            </h2>
            <p class="mt-2 text-center text-sm text-gray-600">
                Secure your account with an authenticator app
            </p>
         </div>
         
         <div class="mt-10 sm:mx-auto w-full">
            <div class="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
                <h3 class="text-sm font-medium text-blue-900 mb-2">Step 1: Install an Authenticator App</h3>
                <p class="text-sm text-blue-800">Download one of these apps on your mobile device:</p>
                <ul class="text-sm text-blue-800 mt-2 space-y-1">
                    <li>• Google Authenticator</li>
                    <li>• Microsoft Authenticator</li>
                    <li>• Authy</li>
                    <li>• Any TOTP-compatible app</li>
                </ul>
            </div>
            
            <div class="bg-green-50 border border-green-200 rounded-lg p-4 mb-6">
                <h3 class="text-sm font-medium text-green-900 mb-3">Step 2: Scan QR Code</h3>
                <div class="flex flex-col items-center">
                    <div class="bg-white p-4 rounded-lg border-2 border-gray-200 mb-4">
                        <img src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="QR Code for TOTP setup" class="w-48 h-48 qr-size">
                    </div>
                    <p class="text-sm text-green-800 text-center">Scan this QR code with your authenticator app</p>
                </div>
            </div>
            
            <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-6">
                <h3 class="text-sm font-medium text-yellow-900 mb-2">Alternative: Manual Entry</h3>
                <p class="text-sm text-yellow-800 mb-2">If you can't scan the QR code, enter this key manually:</p>
                <div class="bg-white rounded border p-3">
                    <code class="text-sm font-mono break-all">${totp.totpSecretEncoded}</code>
                </div>
                <button onclick="copyToClipboard('${totp.totpSecretEncoded}')" class="mt-2 text-xs text-yellow-700 hover:text-yellow-900 underline">
                    Copy to clipboard
                </button>
            </div>
            
            <form action="${url.loginAction}" method="post">
                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                <#if mode??>
                    <input type="hidden" id="mode" name="mode" value="${mode}"/>
                </#if>
                
                <div class="space-y-6">
                    <div>
                        <label for="totp" class="block text-sm/6 font-medium text-gray-900">Step 3: Enter Verification Code</label>
                        <div class="mt-2">
                            <input id="totp" name="totp" type="text" autocomplete="off" 
                                   placeholder="Enter 6-digit code..." 
                                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm/6 px-3 text-center text-lg tracking-widest" 
                                   maxlength="6" 
                                   pattern="[0-9]{6}"
                                   required
                                   autofocus>
                        </div>
                        <p class="mt-2 text-xs text-gray-500">Enter the 6-digit code from your authenticator app to complete setup</p>
                    </div>
                    
                    <#if messagesPerField.existsError('totp','totpSecret')>
                        <div class="rounded-md bg-red-50 p-4">
                            <div class="text-sm text-red-800">${kcSanitize(messagesPerField.getFirstError('totp','totpSecret'))?no_esc}</div>
                        </div>
                    </#if>
                    
                    <div class="flex space-x-4">
                        <button type="submit" class="flex-1 justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm/6 font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">
                            Complete Setup
                        </button>
                        <#if url.loginRestartFlowUrl??>
                            <a href="${url.loginRestartFlowUrl}" class="flex-1 justify-center rounded-md bg-gray-200 px-3 py-1.5 text-sm/6 font-semibold text-gray-900 shadow-sm hover:bg-gray-300 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-gray-500 text-center">
                                Cancel
                            </a>
                        </#if>
                    </div>
                </div>
            </form>
         </div>
      </div>
   </div>
</div>

<script>
// Auto-focus and format the TOTP input
document.addEventListener('DOMContentLoaded', function() {
    const totpInput = document.getElementById('totp');
    if (totpInput) {
        totpInput.focus();
        
        // Format input and validate
        totpInput.addEventListener('input', function(e) {
            const value = e.target.value.replace(/\D/g, ''); // Remove non-digits
            e.target.value = value;
        });
        
        // Only allow numbers
        totpInput.addEventListener('keypress', function(e) {
            if (!/[0-9]/.test(e.key) && !['Backspace', 'Delete', 'Tab', 'Enter'].includes(e.key)) {
                e.preventDefault();
            }
        });
    }
});

// Copy to clipboard function
function copyToClipboard(text) {
    if (navigator.clipboard) {
        navigator.clipboard.writeText(text).then(function() {
            // Show success feedback
            const button = event.target;
            const originalText = button.textContent;
            button.textContent = 'Copied!';
            button.classList.add('text-green-600');
            setTimeout(() => {
                button.textContent = originalText;
                button.classList.remove('text-green-600');
            }, 2000);
        });
    } else {
        // Fallback for older browsers
        const textArea = document.createElement('textarea');
        textArea.value = text;
        document.body.appendChild(textArea);
        textArea.select();
        document.execCommand('copy');
        document.body.removeChild(textArea);
        
        // Show success feedback
        const button = event.target;
        const originalText = button.textContent;
        button.textContent = 'Copied!';
        setTimeout(() => {
            button.textContent = originalText;
        }, 2000);
    }
}
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

    body .max-w-\[240px\] {
        max-width: 420px !important;
        width: 100% !important;
        padding: 2rem !important;
    }


    body .flex.min-h-screen.flex-col.justify-center {
        align-items: center !important;
    }


    body .max-w-\[240px\] h2 {
        font-size: 1.4rem !important;
        line-height: 1.4 !important;
    }

    body .max-w-\[240px\] p {
        line-height: 1.6 !important;
        font-size: 0.95rem !important;
    }


    body .max-w-\[240px\] > div {
        margin-bottom: 1.5rem !important;
    }
    .logo-size{
        width: 100px !important;
        height: 80px !important;
    }

    .qr-size {
        width: 200px !important;
        height: 200px !important;
    }


    body .flex.space-x-4 {
        display: flex !important;
        gap: 1rem !important;
    }

    body .flex.space-x-4 button,
    body .flex.space-x-4 a {
        flex: 1 !important;
    }


    body .max-w-\[240px\] {
        background-color: #ffffff;
        border-radius: 12px !important;
        box-shadow: 0 2px 10px rgba(0,0,0,0.08) !important;
    }
</style>
</@layout.registrationLayout>
