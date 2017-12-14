# GuixSD configs
These are my files I use for making GuixSD a more palatable experience. Each branch refers to a different version of GuixSD. The default branch will be updated to the one corresponding to the latest release I have gotten around to creating a branch for. The default branch will be updated to the one corresponding to the latest release I have gotten around to creating a branch for. 

## 0.14.0
I had to change the config.scm file significantly here as the old version with the SLiM autologin got PAM authentication errors. Logging into SLiM manually with this new configuration file works fine, however. GuixSD lacked one feature I asked about in the #guix IRC channel and I filed a [bug report](https://debbugs.gnu.org/cgi/bugreport.cgi?bug=29706) on it too. The feature was that it was impossible to change the default shell for the root account. Changing the default shell for user accounts was easy by tweaking the config.scm file, but for the root account it was impossible.
