<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>

    <div id="root">
       <div class="main">
          <nav class="navbar navbar-expand-lg navbar-dark">
             <div class="container-fluid">
                <button class="navbar-toggler" type="button"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse">
                   <ul class="navbar-nav mr-auto">
                      <li class="nav-item"></li>
                   </ul>
                </div>
             </div>
          </nav>
          <div class="container d-flex align-items-center justify-content-center">
             <div class="container d-flex justify-content-center align-items-center min-vh-100">
                <div class="col-md-6">
                   <div class="card p-4 shadow">
                      <div class="text-center mb-3">
                         <img src="${url.resourcesPath}/img/logo.png" alt="PlanTripAI Logo" style="width: 100px; height: auto;">
                         <h2 class="forgot-password-main-title mt-3">${msg("emailForgotTitle")}</h2>
                         <h2 class="forgot-password-title mt-3">${msg("emailInstruction")}</h2>
                      </div>
                      <form action="${url.loginAction}" method="post">
                         <div class="form-group"><label for="username" class="forgot-password-label">${msg('username')}</label><input id="username" name="username" type="text" placeholder="Enter your ${msg('username')}" class="form-control" value=""></div>
                         <div class="d-flex justify-content-between mt-4"><a class="forgot-password-label btn btn-link" href="${url.loginUrl}">${kcSanitize(msg('backToLogin'))?no_esc}</a><button type="submit" class="btn btn-custom-secondary">${msg('doSubmit')}</button></div>
                      </form>
                   </div>
                </div>
             </div>
          </div>
       </div>
    </div>

</@layout.registrationLayout>
