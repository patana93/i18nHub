# Translation Management Application

With this application, you can easily manage translations for any application that uses the JSON format.

## Installation

To use the application, you have two options:

1. Download the repository and run the application.
2. Download the latest release for your operating system and run the application.

## Features

The application offers the following features:

- String management (add/edit/delete)
- Ability to group multiple strings into nodes
- Save strings in a single JSON list
- Save strings while preserving node formatting
- Project saving and loading
- Supports 50 different languages (expanding)
- Ability to copy from the default language without rewriting the text
- Duplicate a string key
- Duplicate a string including its value
- Report missing strings in a language
- Select the file path to save the project
- Compatible with macOS, Windows, and Linux (not tested)

## Usage

The top menu of the application manages the project. Follow these steps to get started:
Click on "Make a new project" to create a new project and select the main language. Please note that the main language selection cannot be changed or deleted. This action creates a "main" node where you can add strings.
To add a new string, click on the "+" next to the node name and enter the key for the string. The application will display the list of languages for translation.
For each language, enter the default text and translations. If multiple languages share the same translation (e.g., "OK" in English and Italian), you can use the switch to copy the value from the default language automatically.
If any translations are missing, an alert symbol will appear on the string and the node.
From the top menu, you can edit, delete, or duplicate a key, including its translation values.
Use the save button to save the project. The text at the bottom left of the application indicates the current project or if it has not been saved yet.

### Additional functionality:

- To add more languages, click the "Add language" button at the bottom right and select the desired language.
- To delete a language, click on the "x" on the corresponding chip.
- "Save as JSON" saves all entered strings as individual JSON files, one for each selected language, ignoring the nodes. The files are named according to their localization.
- "Save as JSON with nodes" is similar to "Save as JSON," but it preserves the node structure.
- "Load JSON wizard" allows you to load JSON files (without nodes) and import them into the application, enabling management of any localization JSON file.

## Known Issue

Sometimes, when there are expanded panels and a node is added, it may glitch.
Contributing

We appreciate your interest in contributing to this project! To ensure a smooth collaboration process, please follow the guidelines below:

- Fork the repository and clone it to your local machine.

- Switch to the developer branch

- ``` git checkout developer ```

- Make your changes, improvements, or bug fixes in the developer branch.

- Thoroughly test your changes to ensure they do not introduce any new issues.

- Commit your changes with clear and descriptive commit messages.

- Push your commits to your forked repository.

- Submit a pull request from the developer branch of your forked repository to the developer branch of this main repository.

- Provide a detailed description of your changes in the pull request, including relevant information or context.

- The project maintainers will review your pull request and provide feedback or suggestions if necessary.

### Please note the following guidelines:

- Only contribute to the developer branch to keep the master branch stable and ready for release.
- Follow the coding style and conventions used in the project.
- Please make sure that your changes do not break existing functionality. Include tests if applicable.
- If you are planning significant changes or new features, it is recommended to open an issue to discuss them first, promoting collaboration and avoiding duplication of efforts.
- By contributing to this project, you agree to license your contributions under the same license as the project (Attribution-NonCommercial-ShareAlike 4.0 International).

Thank you for your contributions and for helping to improve this project!

## License

This project is licensed under the Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) License.

### Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

This license allows others to:

- Share: Copy and redistribute the material in any medium or format.
- Adapt: Remix, transform, and build upon the material.

### Under the following terms:

- Attribution: You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
- NonCommercial: You may not use the material for commercial purposes.
- ShareAlike: If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.

For more information about this license, please visit the [Creative Commons website](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Please note that this is a summary of the license. You should refer to the [full text of the license](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode) for the complete terms and conditions.

## Contact Information

Your feedback is highly appreciated. Feel free to send me an email at jumpercode93@gmail.com.

## Todo

The following items are on the to-do list for this project:

- Automatic translation using Google Translate API
- Ability to load JSON files with nodes
- Add languages with localization
- Plurals support
- Generate classes for Flutter/iOS/Android/...
- Autosave functionality
- Improve snackbar notifications
- Code cleanup
- Test on the Linux platform
- Add unit tests
