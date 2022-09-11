# Firefox Settings
You can configure Firefox through the user.js in your profile folder.
Profile folders are name like:<br  />
`$HOME/.mozilla/firefox/random.profile-name`<br  />
The profile name is proceeded by a random string then a dot.
The default profile is `random.default-release`.
This is not to be confused with `random.default`
which is also created but not used? Idk why this is.
If you are using the Firefox Extended Support Release then this will be `random.default-esr`.
(There could be other permutations of `random.default-something` I am not sure)<br  />
The default folder can be found automatically despite the random string with:<br  />
`variable="$(find $HOME/.mozilla/firefox/ -type d -path *.default-release)"`<br  />
You can then copy your user.js into this folder and the settings will take effect.
It is also possible to create a new profile then change the default profile and copy user.js.
Unfortunately I have not found a way to automate this.
You can create a new profile with:<br  />
`firefox -CreateProfile profilename`<br  />
But I have not found a command to change the default profile.
Firefox command line options appear to be poorly documented and many deprecated.

## user.js Examples
[Github arkenfox/user.js](https://github.com/arkenfox/user.js)<br  />
[Github pyllyukko/user.js](https://github.com/pyllyukko/user.js)<br  />
[Github yokoffing/Better-Fox](https://github.com/yokoffing/Better-Fox)<br  />
