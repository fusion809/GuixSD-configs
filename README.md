# GuixSD configs
These are my files I use for making GuixSD a more palatable experience. Each branch refers to a different version of GuixSD. 

## Version 0.14.0
In this release I had to remove segments of the config.scm that were SLiM-related as it caused authentication errors. Without it I can log into SLiM with my user account (fusion809) manually without a problem. It is just irritating having to log in manually. A [bug report](https://debbugs.gnu.org/cgi/bugreport.cgi?bug=29706) arose from this release. It was essentially the discovery that changing root shell is presently impossible using one's configuration file, at least. 
