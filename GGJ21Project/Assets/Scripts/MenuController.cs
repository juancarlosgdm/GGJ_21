using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MenuController : MonoBehaviour {

    private void Start() {
        StartCoroutine(SkipMenu());
    }

    private IEnumerator SkipMenu() {
        yield return new WaitForSeconds(2.0f);
        while (!Input.anyKeyDown) {
            yield return null;
        }
        SceneManager.LoadScene("Intro");
    }
}
