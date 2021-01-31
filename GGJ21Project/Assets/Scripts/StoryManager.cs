using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using System;
using Ink.Runtime;

// This is a super bare bones example of how to play and display a ink story in Unity.
public class StoryManager : MonoBehaviour {
    public static event Action<Story> OnCreateStory;

    [Header("Ink Story")]
    [SerializeField]
    private TextAsset inkJSONAsset = null;
    public Story story;

    [Header("Desktop UI")]
    [SerializeField]
    private GameObject desktopCanvas;

    [Header("Mobile UI")]
    [SerializeField]
    private GameObject mobileCanvas;
    [SerializeField]
    private SuspectAnimations suspectAnimations;
    [Space]
    [SerializeField]
    private Transform conversationContent;
    [SerializeField]
    private Transform conversationChoices;
    [Space]
    [SerializeField]
    private Button nextButton;

    // UI Prefabs
    [SerializeField]
    private Text catherineTextPrefab;
    [SerializeField]
    private Text suspectTextPrefab;
    [SerializeField]
    private Button choicePrefab;

    [Header("Girlfriend UI")]
    [SerializeField]
    private GameObject girldfriendCanvas;
    [Space]
    [SerializeField]
    private Transform girlfriendContent;
    [SerializeField]
    private Transform girlfriendChoices;
    [Space]
    [SerializeField]
    private Button girlfriendNextButton;

    void Start() {
        // Remove the default message
        RemoveChildren();
        StartStory();
    }

    // Creates a new Story object with the compiled story which we can then play!
    void StartStory() {
        story = new Story(inkJSONAsset.text);
        if (OnCreateStory != null) OnCreateStory(story);
        UIController.SetQuestionsPerDay((int)story.variablesState["max_preguntas_dia"]);
        RefreshView();
    }

    // This is the main function called every time the story changes. It does a few things:
    // Destroys all the old content and choices.
    // Continues over all the lines of text, then displays all the choices. If there are no choices, the story is finished!
    void RefreshView() {

        // Remove all the UI on screen
        RemoveChildren();

        // Read all the content until we can't continue any more
        while (story.canContinue) {
            // Continue gets the next line of the story
            string text = story.Continue();
            // This removes any white space from the text.
            text = text.Trim();
            // Display the text on screen!
            if (text.Length > 0) {
                CreateContentView(text, story.currentTags.Contains("catherine"));
            }
        }

        // Display all the choices, if there are any!
        if (story.currentChoices.Count > 0) {
            for (int i = 0; i < story.currentChoices.Count; i++) {
                Choice choice = story.currentChoices[i];
                Button button = CreateChoiceView(choice.text.Trim());
                // Tell the button what to do when we press it
                button.onClick.AddListener(delegate {
                    OnClickChoiceButton(choice);
                });
            }
            // Se asegura que quedan ocultas las opciones para el jugador
            if (mobileCanvas.activeInHierarchy) {
                NextButton(true);
            } else if (girldfriendCanvas.activeInHierarchy) {
                GirlfriendNextButton(true);
            }
        }
        // If we've read all the content and there's no choices, the story is finished!
        else {
            SceneManager.LoadScene(0);
        }

        // Se asegura que los ScrollView se reinicien
        conversationContent.parent.parent.parent.GetComponent<ScrollRect>().verticalNormalizedPosition = 1;
        girlfriendContent.parent.parent.parent.GetComponent<ScrollRect>().verticalNormalizedPosition = 1;

        // Actualiza la interfaz
        UIController.SetRemainingQuestions((int)story.variablesState["max_preguntas_dia"] - (int)story.variablesState["preguntas_realizadas"]);
        UIController.SetRemainingDays((int)story.variablesState["dias_duracion_historia"] - (int)story.variablesState["dias_transcurridos"]);
    }

    // When we click the choice button, tell the story to choose that choice!
    void OnClickChoiceButton(Choice choice) {
        story.ChooseChoiceIndex(choice.index);
        Debug.Log("choicing correcto: " + choice.text);
        RefreshView();
    }

    // Creates a textbox showing the the line of text
    void CreateContentView(string text, bool catherineText) {
        Text storyText;
        if (catherineText) {
            storyText = Instantiate(catherineTextPrefab) as Text;
        } else {
            storyText = Instantiate(suspectTextPrefab) as Text;
        }
        storyText.text = text;

        // Comprueba a qué interfaz corresponde dicha opción
        if (!girldfriendCanvas.activeInHierarchy) {
            storyText.transform.SetParent(conversationContent.transform, false);
        } else {
            storyText.transform.SetParent(girlfriendContent.transform, false);
        }
    }

    // Creates a button showing the choice text
    Button CreateChoiceView(string text) {
        // Creates the button from a prefab
        Button choice = Instantiate(choicePrefab) as Button;

        // Comprueba a qué interfaz corresponde dicha opción
        if (!girldfriendCanvas.activeInHierarchy) {
            choice.transform.SetParent(conversationChoices.transform, false);
        } else {
            choice.transform.SetParent(girlfriendChoices.transform, false);
        }

        // Gets the text from the button prefab
        Text choiceText = choice.GetComponentInChildren<Text>();
        choiceText.text = text;

        // Make the button expand to fit the text
        HorizontalLayoutGroup layoutGroup = choice.GetComponent<HorizontalLayoutGroup>();
        layoutGroup.childForceExpandHeight = false;

        return choice;
    }

    // Destroys all the children of this gameobject (all the UI)
    void RemoveChildren() {
        int childCount = conversationContent.transform.childCount;
        for (int i = childCount - 1; i >= 0; --i) {
            Destroy(conversationContent.transform.GetChild(i).gameObject);
        }
        childCount = conversationChoices.transform.childCount;
        for (int i = childCount - 1; i >= 0; --i) {
            Destroy(conversationChoices.transform.GetChild(i).gameObject);
        }
        childCount = girlfriendContent.transform.childCount;
        for (int i = childCount - 1; i >= 0; --i) {
            Destroy(girlfriendContent.transform.GetChild(i).gameObject);
        }
        childCount = girlfriendChoices.transform.childCount;
        for (int i = childCount - 1; i >= 0; --i) {
            Destroy(girlfriendChoices.transform.GetChild(i).gameObject);
        }
    }

    #region UI Events

    public void GirlfriendNextButton(bool interactable) {
        if ((bool)story.variablesState["novia"]) {
            // Se muestra el panel de las opciones
            girlfriendContent.gameObject.SetActive(interactable);
            girlfriendChoices.gameObject.SetActive(!interactable);
            girlfriendNextButton.interactable = interactable;
        } else {
            // Conversación con la novia terminada, se oculta la interfaz
            girldfriendCanvas.SetActive(false);
            //story.ChooseChoiceIndex(0);
            //Debug.Log("choicing novia");
            RefreshView();
        }
    }

    public void NextButton(bool interactable) {
        if (!(bool)story.variablesState["cambio_personaje"]) {
            // Se muestra el panel de las opciones
            conversationContent.gameObject.SetActive(interactable);
            conversationChoices.gameObject.SetActive(!interactable);
            nextButton.interactable = interactable;
            // Se comprueba si debe mostrarse la interfaz de la novia
            if ((bool)story.variablesState["novia"]) {
                mobileCanvas.SetActive(false);
                girldfriendCanvas.SetActive(true);
                story.ChooseChoiceIndex(0);
                Debug.Log("choicing normal");
                RefreshView();
            }
        } else {
            // Se oculta la interfaz del móvil
            mobileCanvas.SetActive(false);
        }
    }

    public void SuspectSelected(int option) {
        // Activa la interfaz del interrogatorio y notifica la selección
        mobileCanvas.SetActive(true);
        suspectAnimations.SetSuspect(option);
        story.ChooseChoiceIndex(option);
        RefreshView();
    }

    #endregion
}