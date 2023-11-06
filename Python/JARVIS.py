import pyttsx3
import speech_recognition as sr
import datetime
import webbrowser
import wikipedia
import os



#initializing the voice
engine = pyttsx3.init('sapi5')
voices = engine.getProperty('voices')

engine.setProperty('voices',voices[1].id)

#creating a function to convert speach to text
def speak(audio):
    engine.say(audio)
    engine.runAndWait() #without an wait function the speech will not be auidble to us




#a function to wish the user
def wishMe():
    hour = int(datetime.datetime.now().hour)
    print(hour)
    if hour>=12 and hour<4:
        speak("good afternoon")
    elif hour>=16:
        speak("good evening")
    elif hour>=4 and hour<=6:
        speak("good moring but i guess it is still dark")
    elif hour>=0 and hour<6:
        speak("please go to bed and don't disturb")
    else:
        speak("good morning")
        
    speak("i am jarvis . how may i help you")

#creating a function to take command from the user
def takeCommand():
    listner = sr.Recognizer()
    command = list
    try:
        with sr.Microphone() as source:
            print("listening...")
            speak("listening...")
            voice = listner.listen(source)
            command = listner.recognize_google(voice)
            command = command.lower()
            if 'alexa' in command:
                command = command.replace('alexa','')
                print(command)
            return command
    except:
        print("error")
    return command



def main():
    if __name__=="__main__":
        wishMe()
        while True:
            query = takeCommand().lower()
            if 'wikipedia' in query:
                speak('Searching Wikipedia ....')
                query =query.replace("wikipedia","")
                result = wikipedia.summary(query,sentences=2)
                speak("according to wikipedia ...")
                print(result)
                speak(result)
            elif 'open youtube' in query:
                webbrowser.open('youtube.com')
                
            elif "open google" in query:
                webbrowser.open('google.com')
            elif 'play music' in query:
                music_dir = "give the path of your directory"
                songs = os.listdir(music_dir)
                print(songs)
                os.startfile(os.path.join(music_dir,songs[3]))
            elif 'the time' in query:
                strTime = datetime.datetime.now().strftime("%H:%M:%S")
                speak(f"the time is {strTime}")
            elif 'open code' in query:
                codePath="path to the code file"
                os.startfile(codePath)
            elif 'goodbye' in query:
                speak("bye bye")
                os._exit(1)
            else:
                speak("did't get that")
            

main()



