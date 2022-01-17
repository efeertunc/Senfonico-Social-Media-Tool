import sys
import json
import twint
import threading
import lzma
import glob
import instaloader
import os
import shutil
from datetime import datetime
from googleapiclient.discovery import build
from facebook_scraper import get_posts
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, QTimer, QUrl
from PySide2.QtGui import QGuiApplication, QIcon

class storyThread (threading.Thread):
   def __init__(self,name, kullaniciAdi,sifre):
      threading.Thread.__init__(self)

      self.name = name
      self.kullaniciAdi = kullaniciAdi
      self.sifre = sifre


   def run(self):

       self.downloadStories(self.name,self.kullaniciAdi,self.sifre)

   def downloadStories(self, allUsers,kullaniciAdi,sifre):
       L = instaloader.Instaloader()
       L.login(str(kullaniciAdi), str(sifre))

       L2 = instaloader.Instaloader()

       dateDirectory = str(datetime.now().year) + "-" + str(datetime.now().month) + "-" + str(
           datetime.now().day) + " (Story)"

       list_username = allUsers.split("-")

       directoryFirst = dateDirectory
       parent_dirFirst = "C:/Users/" + os.getlogin() + "/Desktop/Senfonico Linkler/"
       path_directoryFirst = os.path.join(parent_dirFirst, directoryFirst)

       try:
           os.makedirs(path_directoryFirst, exist_ok=True)
           path_directoryFirst = os.path.realpath(path_directoryFirst)
           os.startfile(path_directoryFirst)
           print("Directory '%s' created successfully" % directoryFirst)
       except OSError as error:
           print(
               "Dosya önceden oluşturulmuş. Lütfen kontrol et. Hata devam ederse Senfonico Linkler içindeki %s dosyasını silip tekrar deneyebilirsin." % directoryFirst)

       for i in list_username:
           profile = L2.check_profile_id(i)
           L.download_stories(userids=[profile.userid])
           path_stories = "：stories"

           jpg_files = glob.glob(path_stories + "/**/*.jpg", recursive=True)
           json_files = glob.glob(path_stories + "/**/*.xz", recursive=True)
           mp4_files = glob.glob(path_stories + "/**/*.mp4", recursive=True)

           for jsonAd in json_files:

               index = jsonAd.find("json.xz")
               newJson = jsonAd[:33]
               newJpeg = newJson + "jpg"
               newMp4 = newJson + "mp4"
               jpeg = newJpeg.replace("\\", "/")
               mp4 = newMp4.replace("\\", "/")

               with lzma.open(jsonAd, mode='rt') as file:
                   for line in file:
                       a = line.find("username\":\"")
                       c = -1
                       for b in line[a + 11:]:
                           c = c + 1
                           if b == "\"":
                               username = line[a + 11:a + c + 11]
                               directory = username +" " +str(datetime.now().hour)+"."+str(datetime.now().minute)
                               parent_dir = path_directoryFirst
                               path = os.path.join(parent_dir, directory)
                               try:
                                   os.makedirs(path, exist_ok=True)
                               except OSError as error:
                                   print("%s Dosya önceden oluşturulmuş. Lütfen kontrol et" % directory)
                               try:
                                   original = jpeg
                                   target = path
                                   if os.path.isfile(mp4):
                                       shutil.move(mp4, target)
                                   else:
                                       shutil.move(original, target)
                               except shutil.Error as e:
                                   print(e)
                               break
           try:
               shutil.rmtree("：stories")
           except FileNotFoundError as error:
               print(i + " için story bulunamadı")

class instagramThread (threading.Thread):
   def __init__(self,name, dateStart , dateEnd,kullaniciAdi, sifre):
      threading.Thread.__init__(self)
      self.dateStart = dateStart
      self.name = name
      self.dateEnd = dateEnd
      self.kullaniciAdi = kullaniciAdi
      self.sifre = sifre

   def run(self):
       startList = self.dateStart.split("-")
       endList = self.dateEnd.split("-")
       self.getInstagramLink(int(startList[0]),
                             int(startList[1]),
                             int(startList[2]),
                             int(endList[0]),
                             int(endList[1]),
                             int(endList[2]),
                             self.name,self.kullaniciAdi,self.sifre)

   def getInstagramLink(self, sYil, sAy, sGun, eYil, eAy, eGun, allUsers, kullaniciAdi, sifre):
       L = instaloader.Instaloader()
       L.login(str(kullaniciAdi), str(sifre))


       start = datetime(sYil, sAy, sGun)
       end = datetime(eYil, eAy, eGun)

       list_username = allUsers.split("-")

       dateDirectory = str(datetime.now().year) + "-" + str(datetime.now().month) + "-" + str(
           datetime.now().day) + " (Instagram)"

       directoryFirst = dateDirectory
       parent_dirFirst = "C:/Users/" + os.getlogin() + "/Desktop/Senfonico Linkler/"
       path_directoryFirst = os.path.join(parent_dirFirst, directoryFirst)

       try:
           os.makedirs(path_directoryFirst, exist_ok=True)
           path_directoryFirst = os.path.realpath(path_directoryFirst)
           os.startfile(path_directoryFirst)
           print("Directory '%s' created successfully" % directoryFirst)
       except OSError as error:
           print(
               "Dosya önceden oluşturulmuş. Lütfen kontrol et. Hata devam ederse Senfonico Linkler içindeki %s dosyasını silip tekrar deneyebilirsin." % directoryFirst)

       for username in list_username:
           text = path_directoryFirst + "/" + username + " " + str(datetime.now().hour) + "." + str(
               datetime.now().minute) + ".txt"
           f = open(text, 'w')
           a = 0

           profile = instaloader.Profile.from_username(L.context, username)
           posts = profile.get_posts()
           print(username + " ---")

           for post in posts:
               if post.date > start and post.date > end:
                   pass
               elif post.date >= start and post.date <= end:
                   a = 1
                   link = "https://www.instagram.com/p/" + post.shortcode + "/?utm_source=ig_web_copy_link"
                   f.write(link + "\n")
                   print("https://www.instagram.com/p/" + post.shortcode + "/?utm_source=ig_web_copy_link")
               elif post.date <= start:
                   break
           if a == 0:
               f.close()
               os.remove(text)

class twitterThread (threading.Thread):
   def __init__(self,name, dateStart , dateEnd):
      threading.Thread.__init__(self)
      self.dateStart = dateStart
      self.name = name
      self.dateEnd = dateEnd

   def run(self):
       startList = self.dateStart.split("-")
       endList = self.dateEnd.split("-")
       self.getTwitterlink(int(startList[0]),
                             int(startList[1]),
                             int(startList[2]),
                             int(endList[0]),
                             int(endList[1]),
                             int(endList[2]),
                             self.name)

   def getTwitterlink(self, sYil, sAy, sGun, eYil, eAy, eGun, allUsers):


       list_username = allUsers.split("-")

       dateDirectory = str(datetime.now().year) + "-" + str(datetime.now().month) + "-" + str(
           datetime.now().day) + " (Twitter)"

       directoryFirst = dateDirectory
       parent_dirFirst = "C:/Users/" + os.getlogin() + "/Desktop/Senfonico Linkler/"
       path_directoryFirst = os.path.join(parent_dirFirst, directoryFirst)

       try:
           os.makedirs(path_directoryFirst, exist_ok=True)
           path_directoryFirst = os.path.realpath(path_directoryFirst)
           os.startfile(path_directoryFirst)
           print("Directory '%s' created successfully" % directoryFirst)
       except OSError as error:
           print(
               "Dosya önceden oluşturulmuş. Lütfen kontrol et. Hata devam ederse Senfonico Linkler içindeki %s dosyasını silip tekrar deneyebilirsin." % directoryFirst)

       for username in list_username:
           c = twint.Config()
           c.Since = str(sYil) + "-" + str(sAy) + "-" + str(sGun)
           c.Until = str(eYil) + "-" + str(eAy) + "-" + str(eGun)
           c.Store_json = True
           #c.User_id = 'randomstring'
           c.Username = username
           c.Output = username + ".json"

           twint.run.Search(c)

           if os.path.exists(username + ".json"):
               text = path_directoryFirst + "/" + username + " " + str(datetime.now().hour) + "." + str(
                   datetime.now().minute) + ".txt"
               f = open(text, 'w')
               print("Linkler başarıyla alındı")
               tweets = []
               try:
                   for line in open(username + ".json", 'r', encoding='UTF-8'):
                       tweets.append(json.loads(line))
                   print(username)
                   for tweet in tweets:
                       f.write(tweet["link"] + "\n")
                       print(tweet["link"])

                   f.close()
               except Exception as e:
                   print("Okumada bir hata oluştu. Lütfen sonradan yeniden dene.")
               if os.path.exists(username + ".json"):
                   os.remove(username + ".json")
           else:
               print("Belirtilen aralıkta daha fazla link bulunmamaktadır.")

class facebookThread (threading.Thread):
   def __init__(self,name, dateStart , dateEnd):
      threading.Thread.__init__(self)
      self.dateStart = dateStart
      self.name = name
      self.dateEnd = dateEnd

   def run(self):
       startList = self.dateStart.split("-")
       endList = self.dateEnd.split("-")
       self.getFacebookLink(int(startList[0]),
                             int(startList[1]),
                             int(startList[2]),
                             int(endList[0]),
                             int(endList[1]),
                             int(endList[2]),
                             self.name)

   def getFacebookLink(self, sYil, sAy, sGun, eYil, eAy, eGun, allUsers):
       start = datetime(sYil, sAy, sGun)
       end = datetime(eYil, eAy, eGun)

       list_username = allUsers.split("-")

       dateDirectory = str(datetime.now().year) + "-" + str(datetime.now().month) + "-" + str(
           datetime.now().day) + " (Facebook)"

       directoryFirst = dateDirectory
       parent_dirFirst = "C:/Users/" + os.getlogin() + "/Desktop/Senfonico Linkler/"
       path_directoryFirst = os.path.join(parent_dirFirst, directoryFirst)

       try:
           os.makedirs(path_directoryFirst, exist_ok=True)
           path_directoryFirst = os.path.realpath(path_directoryFirst)
           os.startfile(path_directoryFirst)
           print("Directory '%s' created successfully" % directoryFirst)
       except OSError as error:
           print(
               "Dosya önceden oluşturulmuş. Lütfen kontrol et. Hata devam ederse Senfonico Linkler içindeki %s dosyasını silip tekrar deneyebilirsin." % directoryFirst)
       for i in list_username:
           text = path_directoryFirst + "/" + i + " " +str(datetime.now().hour)+"."+str(datetime.now().minute) + ".txt"
           f = open(text, 'w')
           print(i)
           a = 0
           for post in get_posts(i, pages=50):
               if start < post["time"] and post["time"] < end:
                   a = 1
                   f.write(post['post_url'] + "\n")
                   print(post['post_url'])
               elif start > post["time"]:
                   f.close()
                   break
           if a == 0:
               os.remove(text)

class youtubeThread (threading.Thread):
   def __init__(self,name, dateStart , dateEnd):
      threading.Thread.__init__(self)
      self.dateStart = dateStart
      self.name = name
      self.dateEnd = dateEnd

   def run(self):
       startList = self.dateStart.split("-")
       endList = self.dateEnd.split("-")
       self.getYoutubeLink(int(startList[0]),
                             int(startList[1]),
                             int(startList[2]),
                             int(endList[0]),
                             int(endList[1]),
                             int(endList[2]),
                             self.name)

   def getYoutubeLink(self, sYil, sAy, sGun, eYil, eAy, eGun, allUsers):
       api_key = "YOUR YOUTUBE API KEY"
       youtube = build('youtube', 'v3', developerKey=api_key)

       dateDirectory = str(datetime.now().year) + "-" + str(datetime.now().month) + "-" + str(
           datetime.now().day) + " (Youtube)"

       list_of_channel = allUsers.split(".")

       directoryFirst = dateDirectory
       parent_dirFirst = "C:/Users/" + os.getlogin() + "/Desktop/Senfonico Linkler/"
       path_directoryFirst = os.path.join(parent_dirFirst, directoryFirst)

       try:
           os.makedirs(path_directoryFirst, exist_ok=True)
           path_directoryFirst = os.path.realpath(path_directoryFirst)
           os.startfile(path_directoryFirst)
           print("Directory '%s' created successfully" % directoryFirst)
       except OSError as error:
           print(
               "Dosya önceden oluşturulmuş. Lütfen kontrol et. Hata devam ederse Senfonico Linkler içindeki %s dosyasını silip tekrar deneyebilirsin." % directoryFirst)

       for channelID in list_of_channel:
           text = path_directoryFirst + "/" + channelID+" " +str(datetime.now().hour)+"."+str(datetime.now().minute) + ".txt"
           f = open(text, 'w')

           request = youtube.search().list(
               part='id,snippet',
               channelId=channelID,
               type='video',
               order='date',
               fields='nextPageToken,items(id,snippet)',
               maxResults=50,
               publishedAfter=str(sYil) + '-' + str(sAy) + '-' + str(sGun) + 'T00:00:00Z',
               publishedBefore=str(eYil) + '-' + str(eAy) + '-' + str(eGun) + 'T00:00:00Z',
           )

           list_of_links = []

           while request:
               response = request.execute()

               video_link_array = [f"https://www.youtube.com/watch?v={video['id']['videoId']}" \
                                   for video in response['items']]

               for videoLink in video_link_array:
                   list_of_links.append(videoLink)

               request = youtube.search().list_next(
                   request, response)
           print(channelID)
           for link in list_of_links:
               f.write(link + "\n")
               print(link)
           f.close()
           size = os.path.getsize(text)
           if size == 0:
               os.remove(text)

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

    @Slot(str,str,str, str, str)
    def toGetInstagramLink(self, name, dateStart , dateEnd, kullaniciAdi, sifre):
        threadInstagram = instagramThread(name, dateStart, dateEnd, kullaniciAdi, sifre)
        threadInstagram.start()


    @Slot(str, str, str)
    def toGetTwitterLink(self, name, dateStart, dateEnd):
        threadTwitter = twitterThread(name, dateStart, dateEnd)
        threadTwitter.start()

    @Slot(str, str, str)
    def toGetFacebookLink(self, name, dateStart, dateEnd):
        threadFacebook = facebookThread(name, dateStart, dateEnd)
        threadFacebook.start()

    @Slot(str, str, str)
    def toGetYoutubeLink(self, name, dateStart, dateEnd):
        threadYoutube = youtubeThread(name, dateStart, dateEnd)
        threadYoutube.start()


    @Slot(str,str,str)
    def toGetDownloadStory(self, name, kullaniciAdi,sifre):
        threadStory = storyThread(name, kullaniciAdi,sifre)
        threadStory.start()


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Get Context
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    # Set App Extra Info
    app.setOrganizationName("senfoni.co")
    app.setOrganizationDomain("N/A")



    # Set Icon
    app.setWindowIcon(QIcon("senfonico_logo_siyah.ico"))

    # Load Initial Window
    engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
