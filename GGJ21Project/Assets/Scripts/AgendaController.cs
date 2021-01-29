using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AgendaController : MonoBehaviour {
    
    // Start is called before the first frame update
    void Start() {

    }

    // Update is called once per frame
    void Update() {

    }

    #region Suspects Events

    public void StartInterrogation(int suspect) {
        // Comprueba el sospechoso que se quiere interrogar
        switch (suspect) {
            case 0:
                // Patrick
                break;
            case 1:
                // Jennifer
                break;
            case 2:
                // Josh
                break;
        }
    }

    #endregion
}
