package com.toystore.inventory.model.SelectionSort;

import com.toystore.inventory.model.LinkedList.LinkedList;

public class SelectionSort {
    public <T> void selectionSort(LinkedList<T> list, java.util.Comparator<T> comparator) {
        int n = list.size();

        for (int i = 0; i < n - 1; i++) {
            int minIndex = i;

            for (int j = i + 1; j < n; j++) {
                if (comparator.compare(list.get(j), list.get(minIndex)) < 0) {
                    minIndex = j;
                }
            }

            // Swap elements
            T temp = list.get(minIndex);
            list.set(minIndex, list.get(i));
            list.set(i, temp);
        }
    }
}
