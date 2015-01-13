------------------------------------------------------------------------------------------------
About: This is everything that is needed to install an instance of our nb gardens web project 
       for aem.
Team Members: Scott Westover and Brandon Lehman
Version: 1.0
------------------------------------------------------------------------------------------------
Contents
------------------------------------------------------------------------------------------------
Folder Name       Details
***********       *******
checkout          Has a complete vlt checkout of our web project
eclipse           Has all the files for the bundles that were created
installs          Has all the jar files that need to be installed
package 		  A complete package of all our content
------------------------------------------------------------------------------------------------
Install Instructions
------------------------------------------------------------------------------------------------
1. Log into your instance of AEM.
2. Go to http://<host>:<port>/system/console/bundles where <host> is your host name and <port>
   is your port name. 
   Example: If you are running a local instance and your port is set up at 4502: 
   http://localhost:4502/system/console/bundles
3. Click on install/update and install each bundle that is in the 'installs' folder.
4. Got to http://<host>:<port>/crx/de where <host> is your host name and <port> is your port
   name.
   Example: If you are running a local instance and your port is set up at 4502: 
   http://localhost:4502/crx/de
5. Click on the 'Package' button to go to the package manager.
6. Click on 'Upload Package' and install the package that is in the 'package' folder.

						Everything is now installed. 
						
Go to http://<host>:<port>/content/nb-gardens-web-project/login-page.html where <host> is your 
host name and <port> is your port name.
Example: If you are running a local instance and your port is set up at 4502:
http://localhost:4502/content/nb-gardens-web-project/login-page.html
------------------------------------------------------------------------------------------------