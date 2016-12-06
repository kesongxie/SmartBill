<a href="https://courses.codepath.com/snippets/ios_university/prework_university.md" target="_blank">CodePath pre-assignment description</a>

# Pre-work - *SmartBill*

**SmartBill** is a tip calculator application for iOS.

Submitted by: **Kesong Xie**

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is complete:
* User can enter a bill amount, choose a tip percentage, and see the tip and total values.

The following **optional** features are implemented:
* Settings page to change the default tip percentage.
* UI animations
* Remembering the bill amount across app restarts (if <10mins)
* Using locale-specific currency and currency thousands separators.
* Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- Include internationalization for Simplied Han


## Gif walk through
Here's a walkthrough of implemented user stories:

<ul>
<li>
Left: General functionalities showcase, such as dynamically caculates subtotal based on different split count, tip percentages and mode/theme switching
</li>
<li>
Center: Persistent bill amount information that lasts for a certain amount of time
</li>
<li>
Right: Localization and internationalization for the app, includes English and Simplied Han language, different locale currency.
</li>
</ul>
<p align="left">
  <img align="left" src="https://github.com/kesongxie/SmartBill/blob/master/SmartBill/Gif/Part-one.gif" width="250"/>
  <img align="center" src="https://github.com/kesongxie/SmartBill/blob/master/SmartBill/Gif/Part-two.gif" width="250"/>
  <img align="right" src="https://github.com/kesongxie/SmartBill/blob/master/SmartBill/Gif/Part-three.gif" width="250"/>
</p>

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes
Make sure every UI component is up-to-date when the user changes the bill amount before the tip

## License

    Copyright [2016] [Kesong Xie]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
