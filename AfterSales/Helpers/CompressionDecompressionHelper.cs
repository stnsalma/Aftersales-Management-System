using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO.Compression;
using System.IO;

namespace nCloudSiteWeb.Helpers
{
    public class CompressionDecompressionHelper
    {
        public static byte[] Compress(byte[] source) 
        {
            return QuickLZSharp.Compress(source);
            //return GZipCompressionDecompression.Compress(source);
        }
        public static byte[] Decompress(byte[] source) 
        {
            return QuickLZSharp.Decompress(source);
        }

        public static bool Compress(string filePath, string destinationFolder) 
        {
            return QuickLZSharp.Compress(filePath, destinationFolder);
        }

        private static class DeflateCompressionDecompression
        {
            public static byte[] Compress(byte[] data)
            {
                MemoryStream ms = new MemoryStream();
                DeflateStream ds = new DeflateStream(ms, CompressionMode.Compress);

                ds.Write(data, 0, data.Length);
                ds.Flush();
                ds.Close();
                return ms.ToArray();
            }
            public static byte[] Decompress(byte[] data)
            {
                const int BUFFER_SIZE = 1024 * 16;
                byte[] tempArray = new byte[BUFFER_SIZE];
                List<byte[]> tempList = new List<byte[]>();
                int count = 0, length = 0;

                MemoryStream ms = new MemoryStream(data);
                DeflateStream ds = new DeflateStream(ms, CompressionMode.Decompress);

                while ((count = ds.Read(tempArray, 0, BUFFER_SIZE)) > 0)
                {
                    if (count == BUFFER_SIZE)
                    {
                        tempList.Add(tempArray);
                        tempArray = new byte[BUFFER_SIZE];
                    }
                    else
                    {
                        byte[] temp = new byte[count];
                        Array.Copy(tempArray, 0, temp, 0, count);
                        tempList.Add(temp);
                    }
                    length += count;
                }

                byte[] retVal = new byte[length];

                count = 0;
                foreach (byte[] temp in tempList)
                {
                    Array.Copy(temp, 0, retVal, count, temp.Length);
                    count += temp.Length;
                }

                return retVal;
            }
        }

        private static class GZipCompressionDecompression
        {
            //Compression function

            public static void CompressFile(string name_file_source, string compression_name_file_destination)
            {
                FileStream sourceFile = File.OpenRead(name_file_source);
                FileStream destFile = File.Create(compression_name_file_destination);

                GZipStream compstream = new GZipStream(destFile, CompressionMode.Compress);

                const int buf_size = 8192;
                byte[] buffer = new byte[buf_size];
                int bytes_read = 0;
                do
                {
                    bytes_read = sourceFile.Read(buffer, 0, buf_size);
                    compstream.Write(buffer, 0, bytes_read);
                } while (bytes_read != 0);

                compstream.Close();
                sourceFile.Close();
                destFile.Close();
            }

            public static byte[] Compress(byte[] data)
            {
                MemoryStream dest = new MemoryStream();

                GZipStream compstream = new GZipStream(dest, CompressionMode.Compress);

                //compstream.Write(data, 0, data.Length);

                int offset = 0;                
                long totalSize = data.LongLength;
                const int BUFFER_SIZE = 1024 * 16;

                while (totalSize - offset > 0)
                {
                    if (totalSize - offset > BUFFER_SIZE)
                    {
                        compstream.Write(data, offset, BUFFER_SIZE);                        
                        offset += BUFFER_SIZE;
                    }
                    else
                    {
                        compstream.Write(data, offset, Convert.ToInt32(totalSize - offset));
                        offset += Convert.ToInt32(totalSize - offset);
                    }
                } 

                compstream.Close();
                return dest.ToArray();
            }

            //Decompression Function

            public static void DecompressFile(string CompressFilename, string DecompressFileName)
            {
                FileStream sourceFile = File.OpenRead(CompressFilename);
                FileStream destFile = File.Create(DecompressFileName);

                GZipStream compstream = new GZipStream(sourceFile, CompressionMode.Decompress);


                int theByte = compstream.ReadByte();
                while (theByte != -1)
                {
                    destFile.WriteByte((byte)theByte);
                    theByte = compstream.ReadByte();
                }

                compstream.Close();
                sourceFile.Close();
                destFile.Close();

            }

            public static byte[] Decompress(byte[] data)
            {
                const int BUFFER_SIZE = 1024 * 16;
                byte[] tempArray = new byte[BUFFER_SIZE];
                List<byte[]> tempList = new List<byte[]>();
                int count = 0, length = 0;

                MemoryStream ms = new MemoryStream(data);
                GZipStream compstream = new GZipStream(ms, CompressionMode.Decompress);
                
                while ((count = compstream.Read(tempArray, 0, BUFFER_SIZE)) > 0)
                {
                    if (count == BUFFER_SIZE)
                    {
                        tempList.Add(tempArray);
                        tempArray = new byte[BUFFER_SIZE];
                    }
                    else
                    {
                        byte[] temp = new byte[count];
                        Array.Copy(tempArray, 0, temp, 0, count);
                        tempList.Add(temp);
                    }
                    length += count;
                }

                byte[] retVal = new byte[length];

                count = 0;
                foreach (byte[] temp in tempList)
                {
                    Array.Copy(temp, 0, retVal, count, temp.Length);
                    count += temp.Length;
                }

                return retVal;
            }
        }

        private static class QuickLZSharp
        {
            // Only following settings have been ported:
            public const int QLZ_COMPRESSION_LEVEL = 1;
            public const int QLZ_STREAMING_BUFFER = 0;
            public const int QLZ_MEMORY_SAFE = 0;

            public const int QLZ_VERSION_MAJOR = 1;
            public const int QLZ_VERSION_MINOR = 4;
            public const int QLZ_VERSION_REVISION = 1;

            const int HASH_VALUES = 4096;
            const int MINOFFSET = 2;
            const int UNCONDITIONAL_MATCHLEN = 6;
            const int UNCOMPRESSED_END = 4;
            const int CWORD_LEN = 4;
            const int DEFAULT_HEADERLEN = 9;

            private static int headerLen(byte[] source)
            {
                return ((source[0] & 2) == 2) ? 9 : 3;
            }

            public static int sizeDecompressed(byte[] source)
            {
                if (headerLen(source) == 9)
                    return source[5] | (source[6] << 8) | (source[7] << 16) | (source[8] << 24);
                else
                    return source[2];
            }

            public static int sizeCompressed(byte[] source)
            {
                if (headerLen(source) == 9)
                    return source[1] | (source[2] << 8) | (source[3] << 16) | (source[4] << 24);
                else
                    return source[1];
            }

            public static byte[] Compress(byte[] source)
            {
                int src = 0;
                int dst = DEFAULT_HEADERLEN + CWORD_LEN;
                uint cword_val = 0x80000000;
                int cword_ptr = DEFAULT_HEADERLEN;
                byte[] destination = new byte[source.Length + 400];
                int[] hashtable = new int[HASH_VALUES];
                int[] cachetable = new int[HASH_VALUES];
                byte[] hash_counter = new byte[HASH_VALUES];
                byte[] d2;
                int fetch = 0;
                int last_matchstart = (source.Length - UNCONDITIONAL_MATCHLEN - UNCOMPRESSED_END - 1);
                int lits = 0;

                if (source.Length == 0)
                    return new byte[0];

                if (src <= last_matchstart)
                    fetch = source[src] | (source[src + 1] << 8) | (source[src + 2] << 16);

                while (src <= last_matchstart)
                {
                    if ((cword_val & 1) == 1)
                    {
                        if (src > 3 * (source.Length >> 2) && dst > src - (src >> 5))
                        {
                            d2 = new byte[source.Length + DEFAULT_HEADERLEN];
                            d2[0] = 2 | 0;
                            fastwriteN(d2, 1, source.Length + DEFAULT_HEADERLEN, 4);
                            fastwriteN(d2, 5, source.Length, 4);
                            System.Array.Copy(source, 0, d2, DEFAULT_HEADERLEN, source.Length);
                            return d2;
                        }

                        fastwriteN(destination, cword_ptr, (int)((cword_val >> 1) | 0x80000000), 4);
                        cword_ptr = dst;
                        dst += CWORD_LEN;
                        cword_val = 0x80000000;
                    }

                    int hash = ((fetch >> 12) ^ fetch) & (HASH_VALUES - 1);
                    int o = hashtable[hash];
                    int cache = cachetable[hash] ^ fetch;

                    cachetable[hash] = fetch;
                    hashtable[hash] = src;

                    if (cache == 0 && hash_counter[hash] != 0 && (src - o > MINOFFSET || (src == o + 1 && lits >= 3 && src > 3 && source[src] == source[src - 3] && source[src] == source[src - 2] && source[src] == source[src - 1] && source[src] == source[src + 1] && source[src] == source[src + 2])))
                    {
                        cword_val = ((cword_val >> 1) | 0x80000000);
                        if (source[o + 3] != source[src + 3])
                        {
                            int f = 3 - 2 | (hash << 4);
                            destination[dst + 0] = (byte)(f >> 0 * 8);
                            destination[dst + 1] = (byte)(f >> 1 * 8);
                            src += 3;
                            dst += 2;
                        }
                        else
                        {
                            int old_src = src;
                            int remaining = ((source.Length - UNCOMPRESSED_END - src + 1 - 1) > 255 ? 255 : (source.Length - UNCOMPRESSED_END - src + 1 - 1));

                            src += 4;
                            if (source[o + src - old_src] == source[src])
                            {
                                src++;
                                if (source[o + src - old_src] == source[src])
                                {
                                    src++;
                                    while (source[o + (src - old_src)] == source[src] && (src - old_src) < remaining)
                                        src++;
                                }
                            }

                            int matchlen = src - old_src;

                            hash <<= 4;
                            if (matchlen < 18)
                            {
                                int f = (hash | (matchlen - 2));
                                destination[dst + 0] = (byte)(f >> 0 * 8);
                                destination[dst + 1] = (byte)(f >> 1 * 8);
                                dst += 2;
                            }
                            else
                            {
                                fastwriteN(destination, dst, hash | (matchlen << 16), 3);
                                dst += 3;
                            }
                        }
                        fetch = source[src] | (source[src + 1] << 8) | (source[src + 2] << 16);
                        lits = 0;
                    }
                    else
                    {
                        lits++;
                        hash_counter[hash] = 1;
                        destination[dst] = source[src];
                        cword_val = (cword_val >> 1);
                        src++;
                        dst++;
                        fetch = ((fetch >> 8) & 0xffff) | (source[src + 2] << 16);
                    }
                }

                while (src <= source.Length - 1)
                {
                    if ((cword_val & 1) == 1)
                    {
                        fastwriteN(destination, cword_ptr, (int)((cword_val >> 1) | 0x80000000), 4);
                        cword_ptr = dst;
                        dst += CWORD_LEN;
                        cword_val = 0x80000000;
                    }

                    destination[dst] = source[src];
                    src++;
                    dst++;
                    cword_val = (cword_val >> 1);
                }
                while ((cword_val & 1) != 1)
                {
                    cword_val = (cword_val >> 1);
                }
                fastwriteN(destination, cword_ptr, (int)((cword_val >> 1) | 0x80000000), CWORD_LEN);
                destination[0] = 2 | 1;
                fastwriteN(destination, 1, dst, 4);
                fastwriteN(destination, 5, source.Length, 4);
                d2 = new byte[dst];
                System.Array.Copy(destination, d2, dst);
                return d2;
            }

            static void fastwriteN(byte[] a, int i, int N, int n)
            {
                switch (n)
                {
                    case 3:
                        a[i] = (byte)N;
                        a[i + 1] = (byte)(N >> 8);
                        a[i + 2] = (byte)(N >> 16);
                        break;
                    case 2:
                        a[i] = (byte)N;
                        a[i + 1] = (byte)(N >> 8);
                        break;
                    case 4:
                        a[i] = (byte)N;
                        a[i + 1] = (byte)(N >> 8);
                        a[i + 2] = (byte)(N >> 16);
                        a[i + 3] = (byte)(N >> 24);
                        break;
                }
            }

            public static byte[] Decompress(byte[] source)
            {
                int size = sizeDecompressed(source);
                int src = headerLen(source);
                int dst = 0;
                uint cword_val = 1;
                byte[] destination = new byte[size];
                int[] hashtable = new int[4096];
                byte[] hash_counter = new byte[4096];
                int last_matchstart = size - UNCONDITIONAL_MATCHLEN - UNCOMPRESSED_END - 1;
                int last_hashed = -1;
                int hash;
                int fetch = 0;

                if ((source[0] & 1) != 1)
                {
                    byte[] d2 = new byte[size];
                    System.Array.Copy(source, headerLen(source), d2, 0, size);
                    return d2;
                }

                for (; ; )
                {
                    if (cword_val == 1)
                    {
                        cword_val = (uint)(source[src] | (source[src + 1] << 8) | (source[src + 2] << 16) | (source[src + 3] << 24)); // fast_read(src, CWORD_LEN);
                        src += 4;
                        if (dst <= last_matchstart)
                            fetch = source[src] | (source[src + 1] << 8) | (source[src + 2] << 16);
                    }

                    if ((cword_val & 1) == 1)
                    {
                        int matchlen;
                        int offset2;

                        cword_val = cword_val >> 1;
                        hash = (fetch >> 4) & 0xfff;
                        offset2 = hashtable[hash];

                        if ((fetch & 0xf) != 0)
                        {
                            matchlen = (fetch & 0xf) + 2;
                            src += 2;
                        }
                        else
                        {
                            matchlen = source[src + 2];
                            src += 3;
                        }

                        destination[dst + 0] = destination[offset2 + 0];
                        destination[dst + 1] = destination[offset2 + 1];
                        destination[dst + 2] = destination[offset2 + 2];

                        for (int i = 3; i < matchlen; i += 1)
                        {
                            destination[dst + i] = destination[offset2 + i];
                        }
                        dst += matchlen;

                        fetch = destination[last_hashed + 1] | (destination[last_hashed + 2] << 8) | (destination[last_hashed + 3] << 16);
                        while (last_hashed < dst - matchlen)
                        {
                            last_hashed++;
                            hash = ((fetch >> 12) ^ fetch) & (HASH_VALUES - 1);
                            hashtable[hash] = last_hashed;
                            hash_counter[hash] = 1;
                            fetch = fetch >> 8 & 0xffff | destination[last_hashed + 3] << 16;
                        }
                        last_hashed = dst - 1;
                        fetch = source[src] | (source[src + 1] << 8) | (source[src + 2] << 16);
                    }
                    else
                    {
                        if (dst <= last_matchstart)
                        {
                            destination[dst] = source[src];
                            dst += 1;
                            src += 1;
                            cword_val = cword_val >> 1;

                            while (last_hashed < dst - 3)
                            {
                                last_hashed++;
                                int fetch2 = destination[last_hashed] | (destination[last_hashed + 1] << 8) | (destination[last_hashed + 2] << 16);
                                hash = ((fetch2 >> 12) ^ fetch2) & (HASH_VALUES - 1);
                                hashtable[hash] = last_hashed;
                                hash_counter[hash] = 1;
                            }
                            fetch = fetch >> 8 & 0xffff | source[src + 2] << 16;
                        }
                        else
                        {
                            while (dst <= size - 1)
                            {
                                if (cword_val == 1)
                                {
                                    src += CWORD_LEN;
                                    cword_val = 0x80000000;
                                }

                                destination[dst] = source[src];
                                dst++;
                                src++;
                                cword_val = cword_val >> 1;
                            }
                            return destination;
                        }
                    }
                }
            }

            public static bool Compress(string filePath, string destinationFolder) 
            {
                try
                {
                    Byte[] byteSource = System.IO.File.ReadAllBytes(filePath);

                    Byte[] byteSourceCompressed = CompressionDecompressionHelper.QuickLZSharp.Compress(byteSource);

                    byteSource = null;

                    File.Delete(filePath);

                    string fileName = new FileInfo(filePath).Name;

                    CommonHelper.CreateDirectory(destinationFolder);

                    FileStream fs = new FileStream(Path.Combine(destinationFolder, fileName), FileMode.Create);
                    fs.Write(byteSourceCompressed, 0, byteSourceCompressed.Length);

                    fs.Close();

                    byteSourceCompressed = null;

                    return true;
                }
                catch (Exception ex) 
                {
                    return false;
                }
                
            } 
        }
    }
}
