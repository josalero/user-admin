
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
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
         <div class="main-wrapper">
            <img src="${url.resourcesPath}/img/logo.png" alt="plantripsai-logo" class="logo-img-card">
            <div class="col-md-12 login-form">
               <div class="card card-container">
                  <form action="${url.loginAction}" method="post">
                     <div class="form-group">
                        <div class="wrapper">
                           <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 512 512" class="icon" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                              <path d="M256 288c79.5 0 144-64.5 144-144S335.5 0 256 0 112 64.5 112 144s64.5 144 144 144zm128 32h-55.1c-22.2 10.2-46.9 16-72.9 16s-50.6-5.8-72.9-16H128C57.3 320 0 377.3 0 448v16c0 26.5 21.5 48 48 48h416c26.5 0 48-21.5 48-48v-16c0-70.7-57.3-128-128-128z"></path>
                           </svg>
                           <input name="username" type="text" placeholder="Username" class="form-control input" value=""/>
                        </div>
                     </div>
                     <div class="form-group">
                        <div class="wrapper">
                           <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 448 512" class="icon" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                              <path d="M400 224h-24v-72C376 68.2 307.8 0 224 0S72 68.2 72 152v72H48c-26.5 0-48 21.5-48 48v192c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V272c0-26.5-21.5-48-48-48zm-104 0H152v-72c0-39.7 32.3-72 72-72s72 32.3 72 72v72z"></path>
                           </svg>
                           <input id="input-password" name="password" type="password" placeholder="Password" class="form-control input" value=""/>
                        </div>
                     </div>
                     <div class="form-group btn-login"><button type="submit" class="btn btn-secondary btn-block mt-3"><span>Sign in</span></button></div>
                  </form>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
</@layout.registrationLayout>