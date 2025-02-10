# Group 21 AI Mobile Money App

This Flutter application provides a user-friendly interface for common mobile money operations, enhanced with AI-powered recommendations and assistance. This README provides information for end-users on how to use the app's features.

## Features

This app offers the following core mobile money services:

*   **Send Money:** Transfer funds to other mobile money users. The AI provides suggestions on likely amounts, recipient verification, and safety warnings.
*   **Pay Bills:** Pay utility bills (e.g., electricity, water) and other services. The AI predicts bill amounts, suggests optimal payment times, and alerts you to unusual bill changes.
*   **Cash Out:** Locate nearby mobile money agents for cash withdrawal.  The app uses your location (with your permission) to display nearby agents and their details.
*   **Airtime & Bundles:** Purchase airtime and data/voice bundles.  The AI recommends the most cost-effective bundles based on your usage patterns.

## Getting Started (For Users)

This section assumes the app is already installed on your device.  If you are a developer setting up the project, see the "For Developers" section below.

1.  **Launch the App:** Tap the app icon on your device's home screen or app drawer.

2.  **Main Screen:** The main screen ("Home") displays your available balance and provides quick access to the main features:
    *   **Available Balance:**  Shows your current mobile money balance (this is a placeholder in the current version; a real implementation would connect to your account).
    *   **Service Grid:**  Large icons leading to the four main services (Send Money, Pay Bills, Cash Out, Airtime & Bundles).
    *   **Quick Actions:**  Smaller buttons for quick access to "Send Money" and "Airtime".

## Using the Features

### Send Money

1.  Tap "Send Money" from either the Service Grid or Quick Actions.
2.  **Enter Recipient Phone Number:** Input the phone number of the person you want to send money to. As you type, the AI will start providing suggestions.
3.  **Enter Amount:** Input the amount you want to send.  Again, the AI may offer suggestions based on your past transactions (simulated in this version).
4.  **AI Recommendations:** A card will appear below the input fields, displaying:
    *   **Amount:** A suggested amount (default: 5000).
    *   **Recipient:** Whether the recipient is "New" or "Frequent" (simulated).
    *   **Warning:**  "None" or a short warning message (if applicable, simulated).
    *   **Limit:** A suggested safe transaction limit (default: 100000).
5.  **Confirm:** Tap the "Send Money" button.  A confirmation dialog will appear.
6.  **Confirm or Cancel:**  Review the details and tap "Confirm" to send the money or "Cancel" to abort.  If confirmed, a success message will appear.

### Pay Bills

1.  Tap "Pay Bills" on the main screen.
2.  **Enter Bill Type:**  Type the type of bill (e.g., "Electricity", "Water").
3.  **Enter Account Number:** Enter the account number associated with the bill.
4.  **Enter Amount:** Enter the amount you wish to pay.
5.  **AI Suggestions:**  A card will appear, displaying:
    *   **Amount:** A predicted bill amount (default: 10000).
    *   **Time:**  The best time to pay (default: "ASAP").
    *   **Change:**  Indicates if there's an unusual change in the bill (default: "No").
    *   **Tip:** A payment tip (default: "Auto-pay").
6.  **Confirm:** Tap the "Pay Bill" button.  A confirmation dialog will appear.
7.  **Confirm or Cancel:** Review the details and confirm or cancel the payment. A success message will appear upon confirmation.

### Cash Out

1.  Tap "Cash Out" on the main screen.
2.  **Location Permission:** The app will request permission to access your location.  This is *required* to find nearby agents.  If you deny permission, you will see an error message.
3.  **Nearby Agents:**  A list of nearby agents will be displayed (simulated data in this version).  Each agent card shows:
    *   **Name:** The agent's name.
    *   **ID:** The agent's ID.
    *   **Distance:** The approximate distance to the agent.
    *   **Rating:** The agent's rating (simulated).
4.  **Select Agent:** Tap on an agent card to initiate a cash-out.
5.  **Enter Amount:** In the dialog that appears, enter the amount you want to withdraw.
6.  **Confirm:** Tap "Confirm" to proceed with the cash-out (this is a simulated transaction in the current version).

### Airtime & Bundles

1.  Tap "Airtime & Bundles" on the main screen.
2.  **Enter Phone Number:**  Enter the phone number for which you want to buy airtime or a bundle.
3.  **Select Provider:** Choose your mobile network provider from the dropdown menu.
4.  **Choose Bundle Type:** Tap either "Internet Bundles" or "Voice Bundles".
5.  **Select Bundle:** A bottom sheet will appear, listing available bundles.  Tap on the bundle you want to purchase.
6.  **AI Recommendations:**  A card will appear (before you select a specific bundle) displaying:
    *   **Bundle:** A recommended bundle type (default: "Data").
    *   **Timing:**  When to purchase (default: "Now").
    *   **Previous:**  A comparison to previous purchases (default: "Same").
    *   **Next Month:** A prediction for next month's needs (default: "Same").
7.  **Confirm Purchase:** A confirmation dialog will pop up. Click "okay" to make a purchase.

## Important Notes

*   **Simulated Data:**  This version of the app uses *simulated* data for transaction history, agent locations, and AI recommendations.  A real-world application would connect to a backend system to provide accurate data.
*   **Location Services:**  The "Cash Out" feature requires access to your device's location to function correctly.  You can manage location permissions in your device's settings.
*   **API Key:**  The AI features rely on the Google Gemini API. A valid API key must be configured for the AI recommendations to work (this is relevant for developers, see below).
* **Confirmation Dialogs:** All actions that have financial implications (sending, paying, withdrawing) show dialogs to the user to ensure the action is verified.

## For Developers

This section provides information for developers who want to build and run the project.

1.  **Prerequisites:**
    *   Flutter SDK installed and configured.
    *   Dart SDK installed.
    *   A Google Gemini API key.

2.  **Clone the Repository:**
    ```bash
    git clone [repository URL]
    cd [project directory]
    ```

3.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```

4.  **Configure API Key:**
    *   Create a `.env` file in the project's root directory.
    *   Add your Gemini API key to the `.env` file:
        ```
        GEMINI_API_KEY=your_api_key_here
        ```
    *   **Important:**  Do *not* commit your `.env` file to version control (add it to `.gitignore`).

5.  **Run the App:**
    ```bash
    flutter run
    ```

6.  **Project Structure:**

    *   `lib/`: Contains the Dart code.
        *   `main.dart`:  The main entry point of the application.
        *   `screens/`:  Contains the different screens of the app.
        *   `widgets/`:  Contains reusable UI components.
        *   `services/`: Contains services, including the `AIService` for interacting with the Gemini API.
    *   `.env` : a file containing sensitive environment variables such as the API Key

7.  **Dependencies:**

    *   `google_generative_ai`:  For interacting with the Google Gemini API.
    *   `flutter_dotenv`: For loading environment variables (like the API key) from a `.env` file.
    *   `geolocator`: For accessing the device's location (used in the Cash Out feature).
    *   `geocoding`: For converting coordinates to addresses.

This README provides a comprehensive overview of the Group 21 AI Mobile Money app, covering both user instructions and developer setup. Remember to keep your API key secure and do not commit it to version control.