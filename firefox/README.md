# Firefox Settings
You can configure Firefox through the user.js in your firefox profile folder.
Profile folders are named something like:<br/>
`$HOME/.mozilla/firefox/randomcharacters.profile-name`<br/>
The profile name is proceeded by a random string then a dot.
The default profile is `random.default-release`.
This is not to be confused with `random.default`
which is also created but not used? Idk why this is.
If you are using the Firefox Extended Support Release then this will be `random.default-esr`.
There could be other permutations of `random.default-something` I do not know them all<br/>
The default folder can be found automatically despite the random string with:<br/>
`variable="$(find $HOME/.mozilla/firefox/ -type d -path *.default-release)"`<br/>
You can then copy your user.js into this folder and the settings will take effect.
It is also possible to create a new profile then change the default profile and copy user.js.
Unfortunately I have not found a way to automate this.
You can create a new profile with:<br/>
`firefox -CreateProfile profilename`<br/>
But I have not found a command to change the default profile.
Firefox command line options appear to be poorly documented and many deprecated.

## Firefox autoconfig.js
https://github.com/simeononsecurity/FireFox-Privacy-Script<br/>
https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig<br/>

## Firefox Keyboard Shortcuts
[Keyboard Shortcuts](https://support.mozilla.org/en-US/kb/keyboard-shortcuts-perform-firefox-tasks-quickly)<br/>
[Cannot Change Search Engine From user.js](https://stackoverflow.com/questions/47118248/firefox-ignoring-default-search-engine-preferences)<br/>

## user.js Examples
[Github arkenfox/user.js](https://github.com/arkenfox/user.js)<br/>
[Github pyllyukko/user.js](https://github.com/pyllyukko/user.js)<br/>
[Github yokoffing/Betterfox](https://github.com/yokoffing/Betterfox)<br/>

## Policies policies.json
Policy SearchEngines is only allowed on ESR<br/>
The policies.json can be put into
`/etc/firefox/policies/policies.json`
or the firefox distribution directory such as:
`/lib/firefox/distribution/policies.json`<br/>
or<br/>
`/lib/firefox-esr/distribution/policies.json`<br/>
https://support.mozilla.org/en-US/kb/customizing-firefox-using-policiesjson<br/>
https://support.mozilla.org/en-US/kb/managing-policies-linux-desktops<br/>
https://mozilla.github.io/policy-templates/<br/>

## Profiles
https://kb.mozillazine.org/Profiles.ini_file

## uBlock Origin
https://github.com/gorhill/uBlock/wiki/Deploying-uBlock-Origin:-configuration<br/>

## Get Firefox Extension ID
https://support.mozilla.org/en-US/questions/1217302<br/>
https://stackoverflow.com/questions/48056506/get-add-on-id-of-extensions-in-firefox<br/>
