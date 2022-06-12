import time
import base64
from locust import HttpUser, task, between
from random import randint, choice


class User(HttpUser):

    @task
    def catalogue(self):
        username = "test"
        password = "test"
        userpass = f"{username}:{password}"
        encoded_userpass = base64.b64encode(userpass.encode()).decode()
        headers = {"Authorization" : "Basic %s" % encoded_userpass}

        catalogue = self.client.get("/catalogue").json()
        category_item = choice(catalogue)
        item_id = category_item["id"]

        self.client.get("/")
        self.client.get("/login", headers=headers)
        self.client.get("/category.html")
        self.client.get("/detail.html?id={}".format(item_id))
        self.client.delete("/cart")
        self.client.post("/cart", json={"id": item_id, "quantity": 1})
        self.client.get("/basket.html")
        self.client.post("/orders")


