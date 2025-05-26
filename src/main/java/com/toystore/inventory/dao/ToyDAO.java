package com.toystore.inventory.dao;

import com.toystore.inventory.model.Toy;
import com.toystore.inventory.model.LinkedList.LinkedList;
import com.toystore.inventory.model.LinkedList.Node;
import com.toystore.inventory.model.SelectionSort.SelectionSort;

import java.io.*;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class ToyDAO {
    private static final Logger LOGGER = Logger.getLogger(ToyDAO.class.getName());
    private File file;

    public ToyDAO() {
        try {
            String dataPath = "E:/Personal Projects/Online Toy Store/src/main/webapp/WEB-INF/inventorytoys.txt";
            file = new File(dataPath);
            ensureFileExists();
            verifyPermissions();
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error initializing ToyDAO", e);
        }
    }

    private void ensureFileExists() throws IOException {
        File parentDir = file.getParentFile();
        if (!parentDir.exists() && !parentDir.mkdirs()) {
            throw new IOException("Failed to create directory: " + parentDir);
        }
        if (!file.exists() && !file.createNewFile()) {
            throw new IOException("Failed to create file: " + file);
        }
    }

    private void verifyPermissions() {
        if (!file.canRead()) {
            LOGGER.severe("Data file is not readable: " + file.getAbsolutePath());
        }
        if (!file.canWrite()) {
            LOGGER.severe("Data file is not writable: " + file.getAbsolutePath());
        }
    }

    public Toy getToyById(String toyId) {
        return getAllToys().stream()
                .filter(t -> t.getToyId().equals(toyId))
                .findFirst()
                .orElse(null);
    }

    public List<Toy> getAllToys() {
        List<Toy> toys = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",", 6);
                if (parts.length == 6) {
                    try {
                        Toy toy = new Toy(
                                parts[0], // toyId
                                parts[1], // imageName
                                parts[2], // name
                                parts[3], // description
                                Double.parseDouble(parts[4]), // price
                                parts[5]  // ageGroup
                        );
                        toys.add(toy);
                    } catch (NumberFormatException e) {
                        LOGGER.warning("Invalid number format in line: " + line);
                    }
                } else {
                    LOGGER.warning("Skipping invalid line: " + line);
                }
            }
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading toys", e);
        }
        return toys;
    }

    public List<Toy> getToysByAgeGroup(String targetAgeGroup) {
        List<Toy> allToys = getAllToys();

        LinkedList LinkedList = new LinkedList();
        for (Toy toy : allToys) {
            if (toy.getAgeGroup().equalsIgnoreCase(targetAgeGroup)) {
                LinkedList.add(toy.getName().hashCode());
            }
        }

        List<Integer> hashList = new ArrayList<>();
        Node current = LinkedList.head;
        while (current != null) {
            hashList.add((Integer) current.data);
            current = current.next;
        }

        int[] hashArray = new int[hashList.size()];
        for (int i = 0; i < hashList.size(); i++) {
            hashArray[i] = hashList.get(i);
        }

        SelectionSort sorter = new SelectionSort();
        sorter.selectionSort(LinkedList, Comparator.comparingInt(Object::hashCode));

        List<Toy> sortedToys = new ArrayList<>();
        for (int hash : hashArray) {
            for (Toy toy : allToys) {
                if (toy.getAgeGroup().equalsIgnoreCase(targetAgeGroup)
                        && toy.getName().hashCode() == hash
                        && !sortedToys.contains(toy)) {
                    sortedToys.add(toy);
                    break;
                }
            }
        }

        LOGGER.info("Found " + sortedToys.size() + " sorted toys for age group: " + targetAgeGroup);
        return sortedToys;
    }

    public void addToy(Toy toy) {
        try (FileWriter fw = new FileWriter(file, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {
            out.println(toy.toString());
            LOGGER.info("Added toy: " + toy.getName() + " with image: " + toy.getImageName());
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error adding toy", e);
        }
    }

    public Toy getToyByImageName(String imageName) {
        for (Toy toy : getAllToys()) {
            if (toy.getImageName().equals(imageName)) {
                return toy;
            }
        }
        return null;
    }

    public void updateToy(Toy updatedToy) {
        List<Toy> toys = getAllToys();
        for (int i = 0; i < toys.size(); i++) {
            if (toys.get(i).getToyId().equals(updatedToy.getToyId())) {
                toys.set(i, updatedToy);
                break;
            }
        }
        saveAllToys(toys);
        LOGGER.info("Updated toy: " + updatedToy.getName());
    }

    public void deleteToy(String imageName) {
        List<Toy> toys = getAllToys();
        toys.removeIf(toy -> toy.getImageName().equals(imageName));
        saveAllToys(toys);
        LOGGER.info("Deleted toy with image name: " + imageName);
    }

    private void saveAllToys(List<Toy> toys) {
        try (PrintWriter out = new PrintWriter(new FileWriter(file))) {
            for (Toy toy : toys) {
                out.println(toy.toString());
            }
            LOGGER.info("Saved " + toys.size() + " toys to file");
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error saving toys", e);
        }
    }

    public List<Toy> searchToys(String query) {
        List<Toy> results = new ArrayList<>();
        for (Toy toy : getAllToys()) {
            if (toy.getName().toLowerCase().contains(query.toLowerCase()) ||
                    toy.getDescription().toLowerCase().contains(query.toLowerCase())) {
                results.add(toy);
            }
        }
        LOGGER.info("Search for '" + query + "' returned " + results.size() + " results");
        return results;
    }
}
