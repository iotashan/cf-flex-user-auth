# Installation #

  1. Connect your favorite SVN client to http://cf-flex-user-auth.googlecode.com/svn/trunk/ then **export** the trunk as a new project in your workspace. Doing an export will get all the files without any of the links back to the SVN repository.
  1. Set up a virtual host using apache to point to /cf-flex-user-auth/wwwroot
```
<VirtualHost *:80>
    DocumentRoot "D:\webroot\cf-flex-user-auth\wwwroot"
    ServerName cf-flex-user-auth.local
</VirtualHost>
```
  1. Restart Apache
  1. Edit your etc/hosts file (C:\Windows\System32\drivers\etc or /etc/hosts). Add the following line:
```
127.0.0.1	cf-flex-user-auth.local
```
  1. Create a new database and run the script cf-flex-user-auth.sql. Verify the creation of a single table called _users_ with four columns: userID, email, password, verificationCode
  1. Create a new ColdFusion datasource. This example assumes the datasource name _cf-flex-user-auth_.

**Note:** If you change the name of the datasource, you must search for and change the following line in Application.cfc:

```
REQUEST.dsn = "cf-flex-user-auth";
```

If you have completed all these steps, navigating to http://cf-flex-user-auth.local will bring up a screen will load allowing you to Log In Or Create an Account.