"use client";

import { useState, useEffect } from 'react';
import Link from 'next/link';

export default function Home() {
  const [words, setWords] = useState<string[]>([]);
  const [randomWord, setRandomWord] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const loadWords = async () => {
      try {
        const response = await fetch('/words.txt');
        const text = await response.text();
        const wordList = text.split('\n').filter(word => word.trim() !== '');

        if (wordList.length === 0) {
          setError('No words found in the file');
          return;
        }

        setWords(wordList);
        setRandomWord(wordList[Math.floor(Math.random() * wordList.length)]);
      } catch (err) {
        setError('Failed to load words');
      }
    };

    loadWords();
  }, []);

  const getRandomWord = () => {
    if (words.length === 0) return;
    const newWord = words[Math.floor(Math.random() * words.length)];
    setRandomWord(newWord);
  };

  if (error) {
    return (
      <div className="min-h-screen bg-gray-100 flex flex-col items-center justify-center p-4 select-none">
        <div className="text-red-500 font-bold text-center">{error}</div>
      </div>
    );
  }

  return (
    <div
      className="min-h-screen bg-gray-100 flex flex-col items-center justify-center p-4 cursor-pointer select-none"
      onClick={getRandomWord}
    >

      <Link
        href="/login"
        className="absolute top-4 right-4 px-5 py-3 text-white bg-blue-500 rounded-md 
          hover:bg-blue-600 transition-colors z-10 select-none"
        onClick={(e) => e.stopPropagation()}
      >
        Admin Login
      </Link>

      <Link
        href="/add"
        className="absolute top-4 left-4 px-5 py-3 text-white bg-blue-500 rounded-md 
          hover:bg-blue-600 transition-colors z-10 select-none"
        onClick={(e) => e.stopPropagation()}
      >
        Aggiungi parole
      </Link>

      <div className="text-center space-y-8">
        <h1 className="text-4xl font-bold text-gray-800 mb-4 select-none">
          Parole casuali!
        </h1>

        <div className="text-6xl font-medium text-blue-600 transition-all duration-200 
          hover:scale-105 active:scale-95 select-none">
          {randomWord || 'Loading...'}
        </div>

      </div>
    </div>
  );
}