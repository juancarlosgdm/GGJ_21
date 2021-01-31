using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIController : MonoBehaviour {
    /* Singleton */
    private static UIController instance;

    public Text remainingQuestionsText;

    public List<GameObject> calendarDays;

    private int questionsPerDay;

    #region Unity Messages

    void Awake() {
        /* Singleton */
        if (instance == null) {
            instance = this;
        } else if (!instance.Equals(this)) {
            Destroy(gameObject);
        }
    }

    #endregion

    public static void SetQuestionsPerDay(int questions) {
        instance.questionsPerDay = questions;
    }

    public static void SetRemainingDays(int days) {
        for (int i=0; i<instance.calendarDays.Count; i++) {
            instance.calendarDays[i].SetActive(i >= days);
        }
    }

    public static void SetRemainingQuestions(int questions) {
        float percentage = (float)questions / (float)instance.questionsPerDay;
        percentage *= 100;
        instance.remainingQuestionsText.text = (percentage.ToString() + "%");
    }
}