using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SuspectAnimations : MonoBehaviour {
    [Header("Configuration")]
    [SerializeField]
    private float minAnimationTime;
    [SerializeField]
    private float maxAnimationTime;

    [Header("UI References")]
    [SerializeField]
    private Image suspectImage;

    [Header("Sprites")]
    [SerializeField]
    private List<Sprite> patrickSprites;
    [SerializeField]
    private List<Sprite> jenniferSprites;
    [SerializeField]
    private List<Sprite> joshSprites;

    private List<Sprite> currentSuspectSprites;

    private float nextSpriteChange;

    private void Update() {
        if ((currentSuspectSprites != null) && (Time.time > nextSpriteChange)) {
            suspectImage.sprite = currentSuspectSprites[Random.Range(0, currentSuspectSprites.Count)];
            nextSpriteChange = (Time.time + Random.Range(minAnimationTime, maxAnimationTime));
        }
    }

    public void SetSuspect(int suspect) {
        switch (suspect) {
            case -1:
                suspectImage.gameObject.SetActive(false);
                currentSuspectSprites = null;
                break;
            case 0:
                suspectImage.gameObject.SetActive(true);
                suspectImage.sprite = patrickSprites[Random.Range(0, patrickSprites.Count)];
                currentSuspectSprites = patrickSprites;
                break;
            case 1:
                suspectImage.gameObject.SetActive(true);
                suspectImage.sprite = jenniferSprites[Random.Range(0, jenniferSprites.Count)];
                currentSuspectSprites = jenniferSprites;
                break;
            case 2:
                suspectImage.gameObject.SetActive(true);
                suspectImage.sprite = joshSprites[Random.Range(0, joshSprites.Count)];
                currentSuspectSprites = joshSprites;
                break;
        }
    }
}
