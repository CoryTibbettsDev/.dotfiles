# Chromium Preferences
You can configure Chromium through a preferences files that uses json syntax to set options and variables.
By default it is named `Preferences` and it's default location is listed below.

## Location of the Preferences File
The default location is of the `Preferences` file is `$HOME/.config/chromium/Default/Preferences`<br  />
With Google Chrome this would be `$HOME/.config/google-chrome/Default/Preferences`<br  />
I am unsure whether or not chromium respects the `$XDG_CONFIG_HOME` or always uses `$HOME/.config`<br  />
### MacOS
`~/Library/Application\ Support/Google/Chrome/`<br  />
### Windows
`C:\Users\<username>\AppData\Local\Google\Chrome\User Data\`<br  />

## Useful Links
## List of Preferences
[Where can I find a full list of Chrome's master preferences?](https://superuser.com/questions/773614/where-can-i-find-a-full-list-of-chromes-master-preferences)<br  />
[Source Code List of Preferences](https://src.chromium.org/viewvc/chrome/trunk/src/chrome/common/pref_names.cc?view=markup)<br  />
### Community Forum Answers
[How can I customize the default settings when deploying Google Chrome for Business?](https://serverfault.com/questions/635202/how-can-i-customize-the-default-settings-when-deploying-google-chrome-for-busine/635203#635203)<br  />
[Where are Chrome/Chromium preferences stored?](https://askubuntu.com/questions/23620/where-are-chrome-chromium-preferences-stored-to-force-chrome-uniformity-in-fon)<br  />
[Where is the Chrome settings file?](https://superuser.com/questions/149032/where-is-the-chrome-settings-file)<br  />
### Official Documentation
[List of Policies](https://chromeenterprise.google/policies/)<br  />
[Linux Admin Quick Start](https://www.chromium.org/administrators/linux-quick-start/)<br  />
[Documentation for Administrators](https://www.chromium.org/administrators)<br  />
[Basics of the Preferences File for Administrators](https://www.chromium.org/administrators/configuring-other-preferences)<br  />
[The Preferences File for Developers](https://www.chromium.org/developers/design-documents/preferences)<br  />
[Turning Off Auto Updates](https://www.chromium.org/administrators/turning-off-auto-updates)<br  />
