import imaplib
import getpass
import email
from html.parser import HTMLParser


class MyHTMLParser(HTMLParser):
    def handle_data(self, data):
        if data[:1] != "\n":
            self.result.append(data)

    def start(self):
        self.result = []

    def getResult(self):
        return self.result


class MailParse:
    def __init__(self, email, password):
        self.imap = imaplib.IMAP4_SSL('imap.gmail.com', 993)
        self.imap.login(email, password)

    def getAllMessages(self):
        self.imap.select('INBOX')
        status, data = self.imap.search(
            None, '(SUBJECT "' + 'Daily Coding Problem' + '")')
        taskList = []
        if status == 'OK':
            parser = MyHTMLParser()

            for num in data[0].split():
                parser.start()
                status, fetchedData = self.imap.fetch(num, '(RFC822)')
                if status == 'OK':
                    parser.feed(email.message_from_string(
                        fetchedData[0][1].decode('utf-8')).get_payload()[1].as_string())
                taskList.append(parser.getResult())
                parser.close()
        return taskList

    def getUnreadMessages(self):
        self.imap.select('INBOX')
        status, data = self.imap.search(
            None, 'unseen', '(SUBJECT "' + 'Daily Coding Problem' + '")')
        taskList = []
        if status == 'OK':
            parser = MyHTMLParser()

            for num in data[0].split():
                parser.start()
                status, fetchedData = self.imap.fetch(num, '(RFC822)')
                if status == 'OK':
                    parser.feed(email.message_from_string(
                        fetchedData[0][1].decode('utf-8')).get_payload()[1].as_string())
                taskList.append(parser.getResult())
                parser.close()
        return taskList
