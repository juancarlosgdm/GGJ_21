﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIController : MonoBehaviour {
    /* Singleton */
    private static UIController instance;

    public Text remainingQuestionsText;

    public Text remainingDaysText;

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

    public static void SetRemainingDays(int days) {
        string text = instance.remainingDaysText.text;
        text = text.Remove(text.Length - 1);
        instance.remainingDaysText.text = (text + days.ToString());
    }

    public static void SetRemainingQuestions(int questions) {
        string text = instance.remainingQuestionsText.text;
        text = text.Remove(text.Length - 1);
        instance.remainingQuestionsText.text = (text + questions.ToString());
    }
}