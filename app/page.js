'use client';
import { useState } from 'react';
import { Terminal, Shield, Box, Zap, Image as ImageIcon, Copy, Github } from 'lucide-react';
import { motion } from 'framer-motion';

export default function Home() {
  const [copied, setCopied] = useState(false);
  const scriptLoadString = `loadstring(game:HttpGet('https://raw.githubusercontent.com/johsua092-ui/script-premium/main/loader.lua'))()`;

  const copyToClipboard = () => {
    navigator.clipboard.writeText(scriptLoadString);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  return (
    <main className="max-w-6xl mx-auto px-6 py-20 bg-slate-950 text-white min-h-screen">
      <nav className="flex justify-between items-center mb-16">
        <div className="flex items-center gap-2">
          <Shield className="text-blue-500" size={32} />
          <span className="text-xl font-bold">ASU LOADER <span className="text-blue-500">PREMIUM</span></span>
        </div>
      </nav>

      <div className="grid lg:grid-cols-2 gap-12 items-center">
        <div>
          <h1 className="text-5xl font-extrabold mb-6">Build A Boat <br/><span className="text-blue-500">Ultimate Hub</span></h1>
          <p className="text-slate-400 text-lg mb-8">Unlock Premium, No Key, Auto Build, & Fastest Farm.</p>
          <button onClick={copyToClipboard} className="bg-blue-600 hover:bg-blue-700 px-8 py-4 rounded-xl font-bold flex items-center gap-2 transition-all">
            {copied ? 'Copied!' : 'Copy Script'} <Copy size={20} />
          </button>
        </div>

        <div className="bg-slate-900/50 p-8 rounded-2xl border border-white/10">
          <h3 className="text-xl font-bold mb-6 flex items-center gap-2"><Terminal size={20} /> Features</h3>
          <div className="space-y-4">
            <div className="flex gap-4 p-3 bg-slate-800/50 rounded-lg">
              <Box className="text-blue-400" />
              <div><p className="font-bold">Auto Build Shape</p><p className="text-xs text-slate-400">Balls, Cylinder, Triangle</p></div>
            </div>
            <div className="flex gap-4 p-3 bg-slate-800/50 rounded-lg">
              <Zap className="text-yellow-400" />
              <div><p className="font-bold">Fastest Auto Farm</p><p className="text-xs text-slate-400">0-15 seconds per run</p></div>
            </div>
            <div className="flex gap-4 p-3 bg-slate-800/50 rounded-lg">
              <Shield className="text-green-400" />
              <div><p className="font-bold">Save Slot Viewer</p><p className="text-xs text-slate-400">Lihat save slot orang lain</p></div>
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}
