package com.toystore.inventory.model.LinkedList;

public class LinkedList<T> {
    public Node<T> head;

    public void add(T data) {
        Node<T> newNode = new Node<>(data);

        if (head == null) {
            head = newNode;
        } else {
            Node<T> temp = head;
            while (temp.next != null) {
                temp = temp.next;
            }
            temp.next = newNode;
        }
    }

    public int size() {
        int count = 0;
        Node<T> temp = head;
        while (temp != null) {
            count++;
            temp = temp.next;
        }
        return count;
    }

    public T get(int index) {
        int i = 0;
        Node<T> temp = head;
        while (temp != null) {
            if (i == index) return temp.data;
            temp = temp.next;
            i++;
        }
        return null;
    }

    public void set(int index, T data) {
        int i = 0;
        Node<T> temp = head;
        while (temp != null) {
            if (i == index) {
                temp.data = data;
                return;
            }
            temp = temp.next;
            i++;
        }
    }

    public void printList() {
        Node<T> temp = head;
        while (temp != null) {
            System.out.println(temp.data.toString());
            temp = temp.next;
        }
    }
}
