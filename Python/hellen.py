import speech_recognition as sr
import subprocess
import pyttsx3
#import pywhatkit
import datetime
import wikipedia
import webbrowser
import os
import pyautogui as pag
#import pyjokes



listener = sr.Recognizer()
listener.pause_threshold=1
engine =pyttsx3.init()
voices = engine.getProperty("voices")
engine.setProperty('voice',voices[1].id)


def talk(text):
    engine.say(text)
    engine.runAndWait()

#a function to take command from the user
def take_command(): 
    command = "abc"
    try:
        with sr.Microphone() as source:
            voice = listener.listen(source)
            command = listener.recognize_google(voice)
            
            print("ja ji bolea hum sun rahe h...")
            talk("ek min")
           
            
            command = command.lower()
            if 'alexa' in command:
                command = command.replace('alexa','')
                print(command)
            return command
    except:
        print("error")
    return command

#function to switch on wifi
def wifi(status):
    if status=="on":
        subprocess.run (['netsh', 'interface', 'set', 'interface', "wi-fi", "DISABLED"])
        #os.system("netsh interface set interface Wi-Fi enabled")
        talk("switching wifi on")
    elif status=="off":
         os.system("netsh interface set interface Wi-Fi disabled")
         talk("switching wifi off")

#function to open any app
def app(value):
    os.system(f"start {value}")
    talk(f"opening {value}")


#makin the main function
def run_hellen():
    command = take_command()
    print(command)
    if 'time' in command:
        time = datetime.datetime.now().strftime('%I:%M %p')
        talk('Current time is' +time)
    elif 'date' in command:
        talk('sorry, I have a headache')
    elif 'are you single' in command:
        talk('priyanka shutup')
    elif 'open youtube' in command:
            webbrowser.open('youtube.com')
    elif 'switch off wi-fi' in command:
        wifi('off')
    elif 'switch on wi-fi' in command:
        wifi('on')
    elif "open " in command:
        a,b = command.split("open")
        print(a,b)
        app(b)
    elif  "press" in command:
        
            if "+" or "plus" in command:
                if "control" or "ctrl" in command:
                    d=command.split("press")
                    s=d[1]
                    print(d,s)
                    s=s.replace("control","ctrl")
                    s=s.split()
                    print(s)
                    pag.hotkey(s[0],s[1])
                elif "alt" or "alternat" in command:
                    d=command.split("press")
                    print(d)
                    s=d[1]
                    print(d,s)
                    s=s.replace("alt","alt")
                    s=s.split()
                    print(s)
                    pag.hotkey(s[0],s[1])
            
    elif "mouse click" in command:
        pag.click()   
    elif "scroll" in command:
        a= command.split("scroll")
        talk("scrolling")
        pag.scroll(a[1])    
    elif 'goodbye' in command:
         talk("acha to hum chalte he")
         os._exit(1)
    
    else:
        talk('Please say the command again.')

while True:
    run_hellen()



